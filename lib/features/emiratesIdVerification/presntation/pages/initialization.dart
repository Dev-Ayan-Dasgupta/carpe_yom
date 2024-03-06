import 'dart:convert';
import 'dart:developer';

import 'package:carpeyom/config/routes/routes.dart';
import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class VerificationInitializingScreen extends StatefulWidget {
  const VerificationInitializingScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  final Object? argument;

  @override
  State<VerificationInitializingScreen> createState() =>
      _VerificationInitializingScreenState();
}

class _VerificationInitializingScreenState
    extends State<VerificationInitializingScreen> with TextStyleMixin {
  String status = "Downloading Database";

  String progressValue = "0";

  late VerificationInitializationArgumentModel
      verificationInitializationArgument;

  @override
  void initState() {
    super.initState();
    argumentInitialization();
    initPlatformState();

    const EventChannel('flutter_document_reader_api/event/database_progress')
        .receiveBroadcastStream()
        .listen(
      (progress) {
        log("DB Progress -> $progress");
        setState(
          () {
            progressValue = progress;
          },
        );
      },
    );
  }

  void argumentInitialization() {
    verificationInitializationArgument =
        VerificationInitializationArgumentModel.fromMap(
            widget.argument as dynamic ?? {});
  }

  Future<void> initPlatformState() async {
    var prepareDatabase = await DocumentReader.prepareDatabase("ARE");
    log("prepareDatabase -> $prepareDatabase");
    setState(() {
      status = "Initializing";
    });
    ByteData byteData = await rootBundle.load("assets/regula.license");
    var documentReaderInitialization = await DocumentReader.initializeReader({
      "license": base64.encode(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)),
      "delayedNNLoad": true,
    });
    log("documentReaderInitialization -> $documentReaderInitialization");
    setState(() {
      status = "Ready";
    });

    if (context.mounted) {
      Navigator.pushReplacementNamed(
        context,
        Routes.idVerification,
        // arguments: VerificationInitializationArgumentModel(
        //   isReKyc: verificationInitializationArgument.isReKyc,
        // ).toMap(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 50.sp,
              percent: double.parse(progressValue) / 100,
              lineWidth: 5,
              backgroundColor: AppColors.dark30,
              progressColor: AppColors.green100,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                "$progressValue%",
                style: bodyStyle(
                  fontSize: 14.sp,
                  color: AppColors.dark80,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              double.parse(progressValue) < 25
                  ? "Hang tight..."
                  : double.parse(progressValue) < 50
                      ? "Just a few seconds..."
                      : double.parse(progressValue) < 75
                          ? "Getting things ready..."
                          : "Almost there...",
              style: bodyStyle(
                fontSize: 14.w,
                color: AppColors.dark80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VerificationInitializationArgumentModel {
  final bool isReKyc;
  VerificationInitializationArgumentModel({
    required this.isReKyc,
  });

  VerificationInitializationArgumentModel copyWith({
    bool? isReKyc,
  }) {
    return VerificationInitializationArgumentModel(
      isReKyc: isReKyc ?? this.isReKyc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isReKyc': isReKyc,
    };
  }

  factory VerificationInitializationArgumentModel.fromMap(
      Map<String, dynamic> map) {
    return VerificationInitializationArgumentModel(
      isReKyc: map['isReKyc'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerificationInitializationArgumentModel.fromJson(String source) =>
      VerificationInitializationArgumentModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'VerificationInitializationArgumentModel(isReKyc: $isReKyc)';

  @override
  bool operator ==(covariant VerificationInitializationArgumentModel other) {
    if (identical(this, other)) return true;

    return other.isReKyc == isReKyc;
  }

  @override
  int get hashCode => isReKyc.hashCode;
}
