import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:carpeyom/config/routes/routes.dart';

import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/emiratesIdVerification/presntation/pages/index.dart';
import 'package:carpeyom/features/idVerification/presentation/bloc/emiratesIdVerification/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class IdVerificationBloc extends Bloc<IdVerificationEvent, IdVerificationState>
    with TextStyleMixin {
  IdVerificationBloc() : super(EidVerificationInitState()) {
    on<EidScanEvent>(mapEidScanEventToState);
  }

  static bool isEidScanTimedOut = false; // screen
  static bool bothSidesNotScanned = false; // pop-up
  static bool wrongIdTypeScanned = false; //pop-up
  static bool eidBackScannedFirst = false; // pop-up
  static bool eidFrontBackMismatch = false; // pop-up
  static bool eidRegulaError = false; // screen
  static bool eidExists = false; // pop-up
  static bool eidExpired = false; // pop-up
  static bool isEidScanComplete = false; // screen
  static bool eidMinor = false; // screen

  static String fullName = "";
  static String eidNumber = "";
  static String nationality = "";
  static String nationalityCode = "";
  static String expiryDate = "";
  static String dob = "";
  static String gender = "";
  static String photo = "";
  static String docPhoto = "";

  static DocumentReaderCompletion documentReaderCompletion =
      DocumentReaderCompletion();

  FutureOr<void> mapEidScanEventToState(
      EidScanEvent event, Emitter<IdVerificationState> emit) async {
    if (state is EidVerificationInitState) {
      emit(EidScanningState());
      await DocumentReader.showScanner();
      await handleEidScan(documentReaderCompletion);
      if (isEidScanTimedOut) {
        emit(EidScanTimedOutState());
      } else if (bothSidesNotScanned) {
        emit(EidBothSidesNotScannedState());
      } else if (wrongIdTypeScanned) {
        emit(EidWrongIdTypeScannedState());
      } else if (eidBackScannedFirst) {
        emit(EidBackScannedFirstState());
      } else if (eidFrontBackMismatch) {
        emit(EidFrontBackMismatchState());
      } else if (eidRegulaError) {
        emit(EidRegulaErrorState());
      } else if (eidExists) {
        emit(EidExistsState());
      } else if (eidExpired) {
        emit(EidExpiredState());
      } else if (isEidScanComplete) {
        emit(EidScanSuccessState());
      }
      /*
      else if (eidMinor) {
        emit(EidMinorState());
      }
      */
    }
  }

  static Future<void> handleEidScan(DocumentReaderCompletion completion) async {
    if (completion.action == DocReaderAction.COMPLETE) {
      DocumentReaderResults? results = completion.results;

      // ! Check that both the sides are scanned for an EID
      if (results?.documentType.length != 2) {
        bothSidesNotScanned = true;
        return;
      }

      // ! Check that only Emirates ID is used for scanning
      if ((results?.documentType[0]?.dType != DiDocType.dtResidentIdCard ||
              results?.documentType[1]?.dType != DiDocType.dtResidentIdCard) &&
          (results?.documentType[0]?.dType != DiDocType.dtIdentityCard ||
              results?.documentType[1]?.dType != DiDocType.dtIdentityCard)) {
        wrongIdTypeScanned = true;
        return;
      }

      // ! Check that the side one is scanned first
      if (results?.documentType[0]?.pageIndex != 0) {
        eidBackScannedFirst = true;
        return;
      }

      // ! Now check that same EID is used for both front and back
      results?.textResult?.fields.forEach((element) {
        if (element!.values[0]?.value != null) {
          if (element.values[0]?.value?.replaceAll('-', '') !=
              element.values[1]?.value?.replaceAll('-', '')) {
            eidFrontBackMismatch = true;
            return;
          }
        }
      });

      // ! If none of the above error occurs, try to retrieve data

      // 1. Get Full Name
      results?.textResult?.fields.forEach((element) {
        if (element!.fieldType == EVisualFieldType.FT_SURNAME_AND_GIVEN_NAMES &&
            element.lcid == 0 &&
            element.values.length > 1) {
          fullName = element.values[1]!.value ?? "";
          log("fullName -> $fullName");
        }
      });

      // 2. Get EID Number
      eidNumber = await results?.textFieldValueByTypeLcidSource(
            EVisualFieldType.FT_IDENTITY_CARD_NUMBER,
            LCID.LATIN,
            ERPRMResultType.RPRM_RESULT_TYPE_VISUAL_OCR_EXTENDED,
          ) ??
          "";
      log("eidNumber -> $eidNumber");

      // 3. Get Nationality
      nationality = await results?.textFieldValueByTypeLcid(
            EVisualFieldType.FT_NATIONALITY,
            LCID.LATIN,
          ) ??
          "";
      log("nationality -> $nationality");

      // 4. Get Nationality Code
      nationalityCode = await results?.textFieldValueByTypeLcidSource(
              EVisualFieldType.FT_NATIONALITY_CODE,
              LCID.LATIN,
              ERPRMResultType.RPRM_RESULT_TYPE_MRZ_OCR_EXTENDED) ??
          "";
      // Todo: Convert 3 character [nationalityCode] to 2 character [nationalityCode] using mobile backend API
      log("nationalityCode -> $nationalityCode");

      // 5. Get Expiry Date
      expiryDate = await results
              ?.textFieldValueByType(EVisualFieldType.FT_DATE_OF_EXPIRY) ??
          "";
      log("expiryDate -> $expiryDate");

      // 6. Get Date of Birth
      dob = await results
              ?.textFieldValueByType(EVisualFieldType.FT_DATE_OF_BIRTH) ??
          "";
      log("dob -> $dob");

      // 7. Get Gender
      gender = await results?.textFieldValueByTypeLcidSource(
              EVisualFieldType.FT_SEX,
              LCID.LATIN,
              ERPRMResultType.RPRM_RESULT_TYPE_VISUAL_OCR_EXTENDED) ??
          "";
      log("gender -> $gender");

      // 8. Get person's photo from EID
      Uri? photoUri =
          await results?.graphicFieldImageByType(EGraphicFieldType.GF_PORTRAIT);
      photo = photoUri?.path ?? "";
      // 8a. Compress the photo
      photo = await getCompressedImage(photo);
      log("photo -> $photo");

      // 9. Get Document (EID) photo and compress it
      Uri? docPhotoUri = await results
          ?.graphicFieldImageByType(EGraphicFieldType.GF_DOCUMENT_IMAGE);
      docPhoto = docPhotoUri?.path ?? "";
      docPhoto = await getCompressedImage(docPhoto);

      if (containsEmptyField()) {
        eidRegulaError = true;
        return;
      } else {
        // 1. Check if EID Exists, if yes then return
        // Todo: Check for ifEidExists mobile backend API
        // ! if EID exists [eidExists] = true

        // 2. Check if EID expired, if yes then return
        eidExpired = isEidExpired(expiryDate);
        if (eidExpired) {
          return;
        }

        // 3. Check if Age is under 18
        eidMinor = isEidMinor(dob);
        /*
        if (eidMinor) {
          return;
        }
        */

        // 4. Emit Scan Complete
        isEidScanComplete = true;
      }
    } else if (completion.action == DocReaderAction.TIMEOUT) {
      isEidScanTimedOut = true;
    } else {
      eidRegulaError = true;
    }
  }

  static String cleanupBase64Image(String base64Image) {
    base64Image = base64Image.replaceAll("image/png;", "");
    base64Image = base64Image.replaceAll("base64", "");
    base64Image = base64Image.replaceAll(",;", "");
    base64Image = base64Image.replaceAll(",", "");
    base64Image = base64Image.replaceAll("\n", "");

    return base64Image;
  }

  static Future<String> getCompressedImage(String imageString) async {
    String compressedImage = "";

    imageString = cleanupBase64Image(imageString);
    var compressedPhoto = await FlutterImageCompress.compressWithList(
      base64Decode(imageString),
      quality: 30,
    );
    imageString = base64Encode(compressedPhoto);

    return compressedImage;
  }

  static bool containsEmptyField() {
    return fullName.isEmpty ||
        eidNumber.isEmpty ||
        nationality.isEmpty ||
        nationalityCode.isEmpty ||
        expiryDate.isEmpty ||
        dob.isEmpty ||
        gender.isEmpty ||
        photo.isEmpty ||
        docPhoto.isEmpty;
  }

  static bool isEidExpired(String date) {
    return DateTime.parse(DateFormat('yyyy-MM-dd').format(
                DateFormat('dd/MM/yyyy')
                    .parse(date.isEmpty ? "1900-01-01" : date)))
            .difference(DateTime.now())
            .inDays <
        0;
  }

  static bool isEidMinor(String date) {
    return DateTime.now()
            .difference(DateTime.parse(DateFormat('yyyy-MM-dd').format(
                DateFormat('dd/MM/yyyy')
                    .parse(date.isEmpty ? "00/00/0000" : date))))
            .inDays <
        ((18 * 365) + 4);
  }

  // ! Pop-up dialog to show Eid Exists
  void showEidExists(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomDialog(
          svgAssetPath: ImageConstants.alert,
          title: "Oh wait!",
          message: "You seem to be already\nregistered with us.",
          widget: Column(
            children: [
              Text(
                "Please try to login",
                style: bodyStyle(),
              ),
              SizedBox(height: 16.h),
              GradientButton(
                onTap: () {
                  // todo: navigate to login screen
                  Navigator.pop(context);
                },
                text: "Log In",
              ),
            ],
          ),
        );
      },
    );
  }

  // ! Pop-up dialog to show Eid Expired
  void showEidExpired(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomDialog(
          svgAssetPath: ImageConstants.alert,
          title: "Oh no!",
          message:
              "The Emirates ID scanned is invalid or\nexpired, please provide a valid EID.",
          widget: GradientButton(
            onTap: () {
              Navigator.pop(context);
            },
            text: "Rescan",
          ),
        );
      },
    );
  }

  // ! Pop-up dialog to show Eid Mismatch
  void showEidFrontBackMismatch(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomDialog(
          svgAssetPath: ImageConstants.alert,
          title: "Oh no!",
          message: "Front Side and Back Side of the scanned\nID do not match.",
          widget: GradientButton(
            onTap: () {
              Navigator.pop(context);
            },
            text: "Rescan",
          ),
        );
      },
    );
  }

  // ! Pop-up dialog to show Eid Back not scanned
  void showEidBackNotScanned(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomDialog(
          svgAssetPath: ImageConstants.alert,
          title: "Oops!",
          message:
              "We need to capture the backside of your EID (Emirates ID) card. Please flip over your EID card and position it within the scan area. Ensure that the entire backside of the card is visible and well-aligned.",
          widget: SolidButton(
            onTap: () {
              Navigator.pop(context);
            },
            text: "Try Again",
            fontColor: AppColors.green20,
            color: Colors.white,
            borderColor: AppColors.dark50,
          ),
        );
      },
    );
  }

  // ! Pop-up dialog to show scan Eid Front side
  void showScanEidFrontSide(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomDialog(
          svgAssetPath: ImageConstants.alert,
          title: "Oops!",
          message:
              "Failed to scan the front side of your Emirates ID (EID). Please place your EID card with the front side facing up within the scan area. Make sure the entire front side of the card is visible and properly aligned.",
          widget: SolidButton(
            onTap: () {
              Navigator.pop(context);
            },
            text: "Try Again",
            fontColor: AppColors.green20,
            color: Colors.white,
            borderColor: AppColors.dark50,
          ),
        );
      },
    );
  }

  // ! Screen to show Eid scan timed out
  void showEidScanTimedOut(BuildContext context) {
    Navigator.pushNamed(context, Routes.errorSuccess,
        arguments: ErrorSuccessArgumentModel(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageConstants.alertError),
              SizedBox(height: 16.h),
              Text(
                "EID Scan Timed Out",
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
        ).toMap());
  }

  // ! Screen to show Eid Regula Error
  void showEidRegulaError(BuildContext context) {
    Navigator.pushNamed(context, Routes.errorSuccess,
        arguments: ErrorSuccessArgumentModel(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageConstants.alertError),
              SizedBox(height: 16.h),
              Text(
                "Your Scan is unsuccessful",
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
        ).toMap());
  }

  // ! Screen to show Eid Summary
  void showEidSummary(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.eidSummary,
      arguments: EidSummaryArgumentModel(
        details: [
          DetailsTileModel(
            key: "Full Name",
            value: IdVerificationBloc.fullName,
          ),
          DetailsTileModel(
            key: "EID No.",
            value: IdVerificationBloc.eidNumber,
          ),
          DetailsTileModel(
            key: "Nationality",
            value: IdVerificationBloc.nationality,
          ),
          DetailsTileModel(
            key: "EID Expiry Date",
            value: IdVerificationBloc.expiryDate,
          ),
          DetailsTileModel(
            key: "Date of Birth",
            value: IdVerificationBloc.dob,
          ),
          DetailsTileModel(
            key: "Gender",
            value: IdVerificationBloc.gender == "M" ? "Male" : "Female",
          ),
        ],
      ).toMap(),
    );
  }
}
