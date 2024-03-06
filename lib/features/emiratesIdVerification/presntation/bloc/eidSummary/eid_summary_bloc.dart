import 'dart:async';

import 'package:carpeyom/config/routes/routes.dart';

import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/emiratesIdVerification/presntation/bloc/eidSummary/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../idVerification/presentation/bloc/emiratesIdVerification/index.dart';

class EidSummaryBloc extends Bloc<EidSummaryEvent, EidSummaryState>
    with TextStyleMixin {
  EidSummaryBloc() : super(EidSummaryNotAcceptedState()) {
    on<EidSummaryToggleEvent>(mapEidSummaryToggleEventToState);
  }

  FutureOr<void> mapEidSummaryToggleEventToState(
      EidSummaryToggleEvent event, Emitter<EidSummaryState> emit) {
    if (state is EidSummaryNotAcceptedState) {
      emit(EidSummaryAceptedState());
    } else {
      emit(EidSummaryNotAcceptedState());
    }
  }

  void onProceed(BuildContext context) {
    if (IdVerificationBloc.eidMinor) {
      showEidMinorScreen(context);
    } else {
      showEidVerificationComplete(context);
    }
  }

  void showEidMinorScreen(BuildContext context) {
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
              "Oh no!",
              style: bodyStyle(
                color: AppColors.dark100,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              "We are not providing services to users below 18 years of age at the moment.\n\nDo you want us to retain your details for future alerts?",
              style: bodyStyle(),
              textAlign: TextAlign.center,
            )
          ],
        ),
        footer: Column(
          children: [
            GradientButton(
              onTap: () {
                onKeepAccount(context);
              },
              text: "Keep Account",
            ),
            SizedBox(height: 16.h),
            SolidButton(
              onTap: () {
                showDeleteAccountConfirmation(context);
              },
              text: "Delete Account",
              color: Colors.white,
              fontColor: AppColors.green20,
              borderColor: AppColors.dark30,
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ).toMap(),
    );
  }

  void showEidVerificationComplete(BuildContext context) {
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
              "Your Scan is Complete!",
              style: bodyStyle(
                color: AppColors.dark100,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              "Great job! You're closer to completing your verification!",
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
                Navigator.pushReplacementNamed(context, Routes.livenessCheck);
              },
              text: "Continue",
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ).toMap(),
    );
  }

  void onKeepAccount(BuildContext context) {
    Navigator.pop(context);
  }

  void showDeleteAccountConfirmation(BuildContext context) {
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
              "Delete your account?",
              style: bodyStyle(
                color: AppColors.dark100,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              "Are you absolutely sure you want to delete your account?\n\nThis action is irreversible!",
              style: bodyStyle(),
              textAlign: TextAlign.center,
            )
          ],
        ),
        footer: Column(
          children: [
            GradientButton(
              onTap: () {
                onKeepAccount(context);
              },
              text: "No, Keep My Account",
            ),
            SizedBox(height: 16.h),
            SolidButton(
              onTap: () {
                onDeleteAccount(context);
              },
              text: "Yes, Delete My Account",
              color: Colors.white,
              fontColor: AppColors.green20,
              borderColor: AppColors.dark30,
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ).toMap(),
    );
  }

  void onDeleteAccount(BuildContext context) {
    Navigator.pop(context);
  }
}
