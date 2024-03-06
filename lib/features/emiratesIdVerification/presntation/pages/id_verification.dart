import 'dart:convert';

import 'package:carpeyom/config/routes/routes.dart';

import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/idVerification/presentation/bloc/emiratesIdVerification/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IdVerificationScreen extends StatefulWidget {
  const IdVerificationScreen({super.key});

  @override
  State<IdVerificationScreen> createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends State<IdVerificationScreen>
    with TextStyleMixin {
  late EventChannel eventChannel;

  @override
  void initState() {
    super.initState();
    setDocumentReaderConfig();
  }

  Future<void> setDocumentReaderConfig() async {
    DocumentReader.setConfig({
      "functionality": {
        "showCaptureButton": false,
        "showCaptureButtonDelayFromStart": 2,
        "showCaptureButtonDelayFromDetect": 1,
        "showCloseButton": true,
        "showTorchButton": true,
      },
      "customization": {
        "status": "Searching for document",
        "showBackgroundMask": true,
        "backgroundMaskAlpha": 0.6,
        "resultStatus": "Place the EID against a contrasting background"
      },
      "processParams": {
        // "logs": true,
        "dateFormat": "dd/MM/yyyy",
        "scenario": ScenarioIdentifier.SCENARIO_OCR,
        //"timeout": 30.0,
        //"timeoutFromFirstDetect": 30.0,
        "timeoutFromFirstDocType": 30.0,
        "multipageProcessing": true,
        "licenseUpdate": true,
        "debugSaveLogs": true,
        "debugSaveCroppedImages": true,
        "debugSaveRFIDSession": true,
      }
    });
    eventChannel =
        const EventChannel('flutter_document_reader_api/event/completion');
    eventChannel.receiveBroadcastStream().listen((jsonString) {
      IdVerificationBloc.handleEidScan(
        DocumentReaderCompletion.fromJson(
          json.decode(jsonString),
        )!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: appBarShape(),
        shadowColor: Colors.white,
        elevation: 2,
        toolbarHeight: 56.h,
        title: Text(
          "ID Verification",
          style: appBarStyle(),
        ),
        automaticallyImplyLeading: false,
        leading: const AppBarLeading(),
        centerTitle: true,
        flexibleSpace: const AppBarFlexibleSpace(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    "Here is how to scan your Emirates ID",
                    style: headingStyle(),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Scan the front and back side of your Emirates ID.",
                    style: bodyStyle(color: AppColors.black20),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.center,
                    child: Transform.scale(
                      scale: 0.9,
                      child: Image.asset(
                        ImageConstants.eidFront,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Transform.scale(
                      scale: 0.9,
                      child: Image.asset(
                        ImageConstants.eidBack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                BlocConsumer<IdVerificationBloc, IdVerificationState>(
                  listener: (context, state) {
                    if (state is EidScanSuccessState) {
                      // todo: navigate to [summary.dart]
                    } else if (state is EidExistsState) {
                      IdVerificationBloc().showEidExists(context);
                    } else if (state is EidExpiredState) {
                      IdVerificationBloc().showEidExpired(context);
                    } else if (state is EidFrontBackMismatchState) {
                      IdVerificationBloc().showEidFrontBackMismatch(context);
                    } else if (state is EidBothSidesNotScannedState) {
                      IdVerificationBloc().showEidBackNotScanned(context);
                    } else if (state is EidBackScannedFirstState) {
                      IdVerificationBloc().showScanEidFrontSide(context);
                    } else if (state is EidScanTimedOutState) {
                      IdVerificationBloc().showEidScanTimedOut(context);
                    } else if (state is EidRegulaErrorState) {
                      IdVerificationBloc().showEidRegulaError(context);
                    } else if (state is EidScanSuccessState) {
                      IdVerificationBloc().showEidSummary(context);
                    }
                  },
                  builder: (context, state) {
                    return GradientButton(
                      onTap: () {
                        // context.read<IdVerificationBloc>().add(EidScanEvent());
                        IdVerificationBloc().showEidSummary(context);
                      },
                      text: "Scan via Emirates ID",
                      auxWidget: state is EidScanningState
                          ? const ButtonLoader()
                          : const SizedBox.shrink(),
                    );
                  },
                ),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.exploreDashboard);
                  },
                  child: Text(
                    "Skip to Dashboard",
                    style: bodyStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.green20,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.paddingOf(context).bottom),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
