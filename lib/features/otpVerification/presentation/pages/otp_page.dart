import 'dart:async';
import 'dart:developer';
import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/otpVerification/domain/entities/otp_argument.dart';
import 'package:carpeyom/features/otpVerification/presentation/bloc/processVerification/process_verification_bloc.dart';
import 'package:carpeyom/features/otpVerification/presentation/bloc/processVerification/process_verification_event.dart';
import 'package:carpeyom/features/otpVerification/presentation/bloc/processVerification/process_verification_state.dart';
import 'package:carpeyom/utils/helpers/obscure.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({
    Key? key,
    this.argument,
  }) : super(key: key);

  final Object? argument;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> with TextStyleMixin {
  late int seconds;
  int pinputErrorCount = 0;

  bool isSuccess = false;
  bool isRunning = false;
  final TextEditingController _pinController = TextEditingController();

  late OTPArgumentEntity otpArgumentEntity;

  late final String obscuredEmail;
  late final String obscuredPhone;
  Timer? timer;
  @override
  void initState() {
    super.initState();

    argumentInitialization();

    startTimer(otpArgumentEntity.isEmail ? 90 : 90);
  }

  void argumentInitialization() {
    otpArgumentEntity =
        OTPArgumentEntity.fromMap(widget.argument as dynamic ?? {});
    if (otpArgumentEntity.isEmail) {
      obscuredEmail =
          ObscureHelper.obscureEmail(otpArgumentEntity.emailOrPhone);
    } else {
      obscuredPhone =
          ObscureHelper.obscurePhone(otpArgumentEntity.emailOrPhone);
    }
  }

  void startTimer(int count) {
    seconds = count;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          seconds--;
          context
              .read<ProcessVerificationBloc>()
              .add(OtpTimerEvent(seconds: seconds));
        } else {
          timer.cancel();
        }
      },
    );
  }

  void resendOTP() async {
    context.read<ProcessVerificationBloc>().add(OtpInitEvent());
    startTimer(otpArgumentEntity.isEmail ? 90 : 90);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 20,
        toolbarHeight: 70,
        title: Text(
          "Process Verification",
          textAlign: TextAlign.center,
          style: appBarStyle(),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
        leading: InkWell(
          onTap: () {
            ProcessVerificationBloc().onAlertPrompt(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(23.0),
            child: SvgPicture.asset(
              ImageConstants.backButton,
              width: 20.w,
              height: 20.h,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: BlocBuilder<ProcessVerificationBloc, ProcessVerificationState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                    child: Center(
                  child: Column(children: [
                    SizedBox(height: 30.h),
                    SvgPicture.asset(
                      otpArgumentEntity.isEmail
                          ? ImageConstants.processVerification
                          : ImageConstants.mobileProcessVerification,
                      width: 160.w,
                      height: 156.h,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Enter One-Time Password",
                      style: headingStyle(
                          fontSize: 22.w, color: AppColors.black30),
                    ),
                    SizedBox(height: 15.h),
                    otpArgumentEntity.isEmail
                        ? Text(
                            "A 6-digit code has been sent to the email: $obscuredEmail",
                            style: bodyStyle(
                                fontSize: 14.w,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black100),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "A 6 digit code has been sent to phone\nPhone Number: $obscuredPhone",
                            style: bodyStyle(
                                fontSize: 14.w,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black100),
                            textAlign: TextAlign.center,
                          ),
                    SizedBox(height: 25.h),
                    CustomPinput(
                      pinController: _pinController,
                      borderColor: state is OtpSuccessState
                          ? AppColors.green90
                          : state is OtpErrorState
                              ? AppColors.red90
                              : AppColors.black50,
                      onChanged: (p0) async {
                        if (p0.length >= 6) {
                          seconds = 0;
                          timer?.cancel();
                          context
                              .read<ProcessVerificationBloc>()
                              .add(EnterOtpEvent(otp: p0));
                        }
                      },
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20.h),
                        Column(
                          children: [
                            Ternary(
                                condition: state is OtpErrorState,
                                truthy: Text("Invalid Code",
                                    style: bodyStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.red90)),
                                falsy: Text("The code is valid for 90 seconds",
                                    style: bodyStyle())),
                            SizedBox(height: 20.h),
                            Ternary(
                              condition: state is TimerRunningState,
                              truthy: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Resend code ",
                                      style: bodyStyle(
                                          fontSize: 16.w,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black80)),
                                  Text(
                                    "(${seconds ~/ 60}:${seconds % 60})",
                                    style: bodyStyle(
                                      fontSize: 16.w,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black80,
                                    ),
                                  ),
                                ],
                              ),
                              falsy: InkWell(
                                onTap: () {
                                  _pinController.clear();
                                  resendOTP();
                                },
                                child: Text(
                                  "Resend code",
                                  style: bodyStyle(
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.green20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                )),
                Column(
                  children: [
                    state is OtpSuccessState
                        ? GradientButton(
                            onTap: () {
                              context
                                  .read<ProcessVerificationBloc>()
                                  .add(OtpInitEvent());
                              ProcessVerificationBloc()
                                  .showAlertSuccess(context, otpArgumentEntity);
                            },
                            text: "Verify",
                            // auxWidget: state is LoginLoading
                            //     ? const LoaderRow()
                            //     : const SizedBox(),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
                const FooterPadding(),
              ],
            );
          },
        ),
      ),
    );
  }
}
