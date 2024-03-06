import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:carpeyom/config/routes/routes.dart';

import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/liveness/presentation/bloc/livenessCheck/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_face_api/face_api.dart' as regula;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../idVerification/presentation/bloc/emiratesIdVerification/index.dart';

class LivenessCheckBloc extends Bloc<LivenessCheckEvent, LivenessCheckState>
    with TextStyleMixin {
  LivenessCheckBloc() : super(LivenessCheckFailedState()) {
    on<LivenessCheckEvent>(mapLivenessCheckEventToState);
  }

  bool doesEidPhotoSelfieMatch = false;

  String selfiePhoto = "";
  regula.MatchFacesImage image1 = regula.MatchFacesImage();
  regula.MatchFacesImage image2 = regula.MatchFacesImage();
  Image img1 = Image.memory(base64Decode(IdVerificationBloc.photo != null
      ? cleanupBase64Image((IdVerificationBloc.photo))
      : ""));
  Image img2 = Image.asset(ImageConstants.eidFront);
  double photoMatchScore = 0;

  FutureOr<void> mapLivenessCheckEventToState(
      LivenessCheckEvent event, Emitter<LivenessCheckState> emit) async {
    emit(LivenessCheckScanningState());
    initializeFaceSdk();
    await startFaceScan();
    if (doesEidPhotoSelfieMatch) {
      emit(LivenessCheckSuccessState());
    } else {
      emit(LivenessCheckFailedState());
    }
  }

  void initializeFaceSdk() {
    // EventChannel as per Regula Documentation to listen to selie liveness scan
    regula.FaceSDK.init().then((json) {
      var response = jsonDecode(json);
      if (!response["success"]) {}
    });
    const EventChannel('flutter_face_api/event/video_encoder_completion')
        .receiveBroadcastStream()
        .listen((event) {
      var response = jsonDecode(event);
      String transactionId = response["transactionId"];
      bool success = response["success"];
      log("video_encoder_completion:");
      log("success: $success");
      log("transactionId: $transactionId");
    });
  }

  Future<void> startFaceScan() async {
    // Start Regula Liveness Scan screen
    var value = await regula.FaceSDK.startLiveness();

    // After Regula Scan completes, it will return a LivenessResponse
    var result = regula.LivenessResponse.fromJson(json.decode(value));

    // From the LivenessResponse, extract the base64 image of selfie
    selfiePhoto = result!.bitmap!.replaceAll("\n", "");
    selfiePhoto = cleanupBase64Image(selfiePhoto);

    // Compress the selfie
    var compressedSelfie = await FlutterImageCompress.compressWithList(
      base64Decode(selfiePhoto),
      quality: 30,
    );
    selfiePhoto = base64Encode(compressedSelfie);

    // Extract bitmap images of EID person's photo with selfie photo for [matchfaces()]
    image1.bitmap = base64Encode(base64Decode(IdVerificationBloc.photo != null
        ? IdVerificationBloc.photo.replaceAll("\n", "")
        : ""));
    image1.imageType = regula.ImageType.PRINTED;
    image2.bitmap = base64Encode(base64Decode(selfiePhoto));
    image2.imageType = regula.ImageType.LIVE;
    img2 = Image.memory(base64Decode(selfiePhoto));

    await matchFaces();

    //if matchfaces returns >= 80% match, then set [doesEidPhotoSelfieMatch] to true
    if (photoMatchScore >= 80) {
      doesEidPhotoSelfieMatch = true;
    }
  }

  Future<void> matchFaces() async {
    // We will compare match by calling MatchFacesRequest of Regula library
    regula.MatchFacesRequest request = regula.MatchFacesRequest();
    request.images = [image1, image2];
    var value = await regula.FaceSDK.matchFaces(jsonEncode(request));
    var response = regula.MatchFacesResponse.fromJson(json.decode(value));

    // Call matchFacesSimilarityThresholdSplit() method to see if any pair of matching faces is returned as a list item having 80% match
    var str = await regula.FaceSDK.matchFacesSimilarityThresholdSplit(
        jsonEncode(response!.results), 0.8);
    regula.MatchFacesSimilarityThresholdSplit? split =
        regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));

    // If the list returns matched faces pair, then score is similarity * 100, else 0
    photoMatchScore = split!.matchedFaces.isNotEmpty
        ? (split.matchedFaces[0]!.similarity! * 100)
        : 0;
  }

  static String cleanupBase64Image(String? base64Image) {
    base64Image = base64Image?.replaceAll("image/png;", "");
    base64Image = base64Image?.replaceAll("base64", "");
    base64Image = base64Image?.replaceAll(",;", "");
    base64Image = base64Image?.replaceAll(",", "");
    base64Image = base64Image?.replaceAll("\n", "");

    return base64Image ?? "";
  }

  void showLivenessCheckFailed(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.errorSuccess,
      arguments: ErrorSuccessArgumentModel(
        header: AppBar(
          shape: appBarShape(),
          shadowColor: Colors.white,
          elevation: 2,
          toolbarHeight: 56.h,
          automaticallyImplyLeading: false,
          actions: const [SupportAgent()],
          flexibleSpace: const AppBarFlexibleSpace(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImageConstants.alertError),
            SizedBox(height: 16.h),
            Text(
              "Verification Failed",
              style: bodyStyle(
                color: AppColors.dark100,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              "Please try again",
              style: bodyStyle(),
              textAlign: TextAlign.center,
            )
          ],
        ),
        footer: Column(
          children: [
            GradientButton(
              onTap: () {
                Navigator.pop(context);
              },
              text: "Try Again",
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ).toMap(),
    );
  }

  void showLivenessCheckSuccess(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.errorSuccess,
      arguments: ErrorSuccessArgumentModel(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImageConstants.alert),
            SizedBox(height: 16.h),
            Text(
              "Success!",
              style: bodyStyle(
                color: AppColors.dark100,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              "Your selfie verification is completed",
              style: bodyStyle(),
              textAlign: TextAlign.center,
            )
          ],
        ),
        footer: Column(
          children: [
            GradientButton(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, Routes.addressDetails);
              },
              text: "Continue",
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ).toMap(),
    );
  }
}
