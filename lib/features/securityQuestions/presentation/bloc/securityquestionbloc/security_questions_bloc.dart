import 'dart:async';

import 'package:carpeyom/config/routes/routes.dart';
import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/securityQuestions/presentation/bloc/securityquestionbloc/security_questions_event.dart';
import 'package:carpeyom/features/securityQuestions/presentation/bloc/securityquestionbloc/security_questions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecurityQuestionBloc
    extends Bloc<SecurityQuestionEvent, SecurityQuestionState>
    with TextStyleMixin {
  SecurityQuestionBloc() : super(SecurityQuestionInitState()) {
    on<SecurityQuestionEnableButton>(
        mapSecurityQuestionEnableButtonEventToState);
  }

  static bool isError = false;
  static bool isSuccess = false;

  FutureOr<void> mapSecurityQuestionEnableButtonEventToState(
      SecurityQuestionEnableButton event, Emitter<dynamic> emit) {
    onChanged(event.isEnable);
    if (isError) {
      emit(SecurityQuestionErrorState());
    } else if (isSuccess) {
      emit(SecurityQuestionSuccessState());
    }
  }

  //! Checked question field empty or not
  static void onChanged(bool isEnable) {
    if (isEnable) {
      isError = false;
      isSuccess = true;
    } else {
      isError = true;
      isSuccess = false;
    }
  }

// ! Screen to show success Alert Email  & Mobile Verified
  void showAlertSuccess(
    BuildContext context,
  ) {
    Navigator.pushNamed(context, Routes.errorSuccess,
        arguments: ErrorSuccessArgumentModel(
          header: AppBar(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            automaticallyImplyLeading: false,
          ),
          //backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 110.h),
              SvgPicture.asset(
                ImageConstants.succesAlert,
              ),
              SizedBox(height: 16.h),
              Text(
                "Account created successfully",
                style: bodyStyle(
                  color: AppColors.dark100,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              Text(
                "Great job! You’ve completed the\n onboarding journey",
                style: bodyStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          footer: Column(
            children: [
              GradientButton(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.home,
                  );
                },
                text: "Continue",
                // auxWidget: state is LoginLoading
                //     ? const LoaderRow()
                //     : const SizedBox(),
              ),
              const FooterPadding(),
            ],
          ),
        ).toMap());
  }
}
