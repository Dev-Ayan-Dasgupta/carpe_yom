import 'dart:async';

import 'package:carpeyom/config/routes/routes.dart';
import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/createpassword/domain/entities/create_account.dart';
import 'package:carpeyom/features/emailVerification/domain/entities/registration_argument.dart';
import 'package:carpeyom/features/otpVerification/domain/entities/otp_argument.dart';
import 'package:carpeyom/features/otpVerification/presentation/bloc/processVerification/process_verification_event.dart';
import 'package:carpeyom/features/otpVerification/presentation/bloc/processVerification/process_verification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProcessVerificationBloc
    extends Bloc<ProcessVerificationEvent, ProcessVerificationState>
    with TextStyleMixin {
  ProcessVerificationBloc() : super(OtpInitState()) {
    on<EnterOtpEvent>(mapEnterOtpEventToState);
    on<OtpTimerEvent>(mapOtpTimerEventToState);
    on<OtpInitEvent>(mapOtpInitEventToState);
  }

  static bool isInit = true;
  static bool isSuccess = false;
  static bool isError = false;
  static bool isRunning = true;
  static bool isEnd = false;

  FutureOr<void> mapEnterOtpEventToState(
      EnterOtpEvent event, Emitter<ProcessVerificationState> emit) {
    onChanged(event.otp);
    if (isInit) {
      emit(OtpInitState());
    } else if (isError) {
      emit(OtpErrorState());
    } else if (isSuccess) {
      emit(OtpSuccessState());
    }
  }

//validation for otp
  static void onChanged(String otp) {
    if (otp.isEmpty) {
      isSuccess = false;
      isError = false;
      isInit = true;
    } else if (otp == "123456") {
      isSuccess = true;
      isError = false;
      isInit = false;
    } else {
      isSuccess = false;
      isError = true;
      isInit = false;
    }
  }

  FutureOr<void> mapOtpTimerEventToState(
      OtpTimerEvent event, Emitter<ProcessVerificationState> emit) {
    onTimerProgress(event.seconds);
    if (isRunning) {
      emit(TimerRunningState());
    } else if (isEnd) {
      emit(TimerEndState());
    }
  }

  // checked Timer progress
  static void onTimerProgress(int seconds) {
    if (seconds == 0) {
      isRunning = false;
      isEnd = true;
    } else {
      isRunning = true;
      isEnd = false;
    }
  }

  FutureOr<void> mapOtpInitEventToState(
      OtpInitEvent event, Emitter<ProcessVerificationState> emit) {
    emit(OtpInitState());
  }

// ! Pop-up dialog for Go Back Confirmation
  void onAlertPrompt(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          svgAssetPath: ImageConstants.alert,
          title: "Hey!",
          message: "Are you sure you want to go back?",
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SolidButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    height: 55.h,
                    width: 134.w,
                    text: "No",
                    fontColor: AppColors.green20,
                    fontSize: 15.w,
                    borderColor: const Color.fromRGBO(0, 0, 0, 0.2),
                    borderRadius: 10.w,
                    color: Colors.white,
                  ),
                  GradientButton(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      showRegistration(context);
                    },
                    height: 55.h,
                    width: 134.w,
                    text: "Yes",
                    fontSize: 15.w,
                    borderRadius: 10.w,
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        );
      },
    );
  }

  // ! Screen to show Lets Start(Registration)
  void showRegistration(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      Routes.registration,
      arguments: RegistrationArgumentEntity(
        isInitial: true,
        isUpdateCorpEmail: false,
      ).toMap(),
    );
  }

// ! Screen to show success Alert Email  & Mobile Verified
  void showAlertSuccess(
    BuildContext context,
    OTPArgumentEntity otpArgumentEntity,
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
                "Success!",
                style: bodyStyle(
                  color: AppColors.dark100,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              otpArgumentEntity.isEmail
                  ? Text(
                      "Your email address is verified\n successfully.",
                      style: bodyStyle(),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      "Your mobile number is verified\n successfully.",
                      style: bodyStyle(),
                      textAlign: TextAlign.center,
                    )
            ],
          ),
          footer: Column(
            children: [
              GradientButton(
                onTap: () {
                  otpArgumentEntity.isEmail
                      ? Navigator.pushReplacementNamed(
                          context,
                          Routes.createPasword,
                          arguments: CreateAccountArgumentEntity(
                            email: otpArgumentEntity.emailOrPhone,
                            isRetail: true,
                            userTypeId: 1,
                            companyId: 0,
                          ).toMap(),
                        )
                      : Navigator.pushReplacementNamed(
                          context,
                          Routes.securityQuestion,
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
