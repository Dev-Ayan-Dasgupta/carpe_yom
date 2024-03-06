import 'package:carpeyom/config/routes/routes.dart';
import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/emailVerification/domain/entities/registration_argument.dart';
import 'package:carpeyom/features/otpVerification/domain/entities/otp_argument.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/letsStartbloc/lets_start_bloc.dart';

class LetsStartPage extends StatefulWidget {
  const LetsStartPage({
    Key? key,
    this.argument,
  }) : super(key: key);

  final Object? argument;

  @override
  State<LetsStartPage> createState() => _LetsStartPageState();
}

class _LetsStartPageState extends State<LetsStartPage> with TextStyleMixin {
  final TextEditingController _emailController = TextEditingController();
  //bool isEmailValid = false;
  RegistrationArgumentEntity? registrationArgument;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    registrationArgument =
        RegistrationArgumentEntity.fromMap(widget.argument as dynamic ?? {});
    context.read<LetsStartBloc>().add(const EnterEmailEvent(email: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      shape: appBarShape(),
      shadowColor: Colors.white,
      elevation: 2,
      toolbarHeight: 63.h,
      title: Text(
        "Let's start",
        style: appBarStyle(),
      ),
      automaticallyImplyLeading: false,
      // leading: const AppBarLeading(),
      centerTitle: true,
      flexibleSpace: const AppBarFlexibleSpace(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: BlocConsumer<LetsStartBloc, LetsStartState>(
        listener: (context, state) {
          if (state is LetsStartEmailState) {
            isValid = state.isValid;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 30),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      "Enter your email address",
                      style: headingStyle(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "This will be used as your User ID for your account creation",
                      style: bodyStyle(
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black20),
                    ),
                    SizedBox(height: 30.h),
                    CustomTextField(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Email Address (User ID)",
                            style: hintStyle(
                              fontSize: 12.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.dark80,
                            ),
                          ),
                          const Asterisk(),
                        ],
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          ImageConstants.envelope,
                          width: 20,
                          height: 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                      hintText: "Enter Email Address (User ID)",
                      focussedBorderColor: _emailController.text.isEmpty
                          ? AppColors.black5
                          : isValid
                              ? AppColors.black100
                              : AppColors.red90,
                      controller: _emailController,
                      suffix: _emailController.text.isEmpty
                          ? const SizedBox.shrink()
                          : isValid
                              ? Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: SvgPicture.asset(
                                    ImageConstants.checkCircle,
                                    width: 20.w,
                                    height: 20.w,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: InkWell(
                                    onTap: () {
                                      _emailController.clear();

                                      _emailController.text.isEmpty
                                          ? context.read<LetsStartBloc>().add(
                                              const EnterEmailEvent(email: ""))
                                          : context.read<LetsStartBloc>().add(
                                              EnterEmailEvent(
                                                  email:
                                                      _emailController.text));
                                    },
                                    child: SvgPicture.asset(
                                      ImageConstants.deleteText,
                                      width: 17.w,
                                      height: 17.w,
                                    ),
                                  ),
                                ),
                      onChanged: (p0) {
                        context
                            .read<LetsStartBloc>()
                            .add(EnterEmailEvent(email: p0));
                      },
                    ),
                    SizedBox(height: 10.h),
                    BlocBuilder<LetsStartBloc, LetsStartState>(
                        builder: (context, state) {
                      if ((state is LetsStartEmailState && state.isInit) ||
                          (state is LetsStartEmailState && state.isValid)) {
                        return const SizedBox.shrink();
                      } else {
                        return Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(height: 20.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: SvgPicture.asset(
                                    ImageConstants.errorCircle,
                                    height: 14.h,
                                    width: 14.w,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    "Invalid Email Address",
                                    style: bodyStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.w,
                                        color: AppColors.red90),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }
                    }),

                    // isValid || _emailController.text.isEmpty
                    //     ? const SizedBox.shrink()
                  ] //     :                   ],
                      )),
              Column(
                children: [
                  isValid
                      ? GradientButton(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.otp,
                              arguments: OTPArgumentEntity(
                                emailOrPhone: _emailController.text,
                                // storageEmail ?? _emailController.text,
                                isEmail: true,
                                isBusiness:
                                    registrationArgument!.isUpdateCorpEmail
                                        ? true
                                        : false,
                                isInitial: registrationArgument!.isInitial,
                                isLogin: false,
                                isEmailIdUpdate:
                                    !(registrationArgument!.isInitial),
                                isMobileUpdate: false,
                                isReKyc: false,
                              ).toMap(),
                            );
                          },
                          text: "Proceed",
                          // auxWidget: state is LoginLoading
                          //     ? const LoaderRow()
                          //     : const SizedBox(),
                        )
                      : SolidButton(
                          onTap: () {},
                          text: "Proceed",
                          fontColor: AppColors.black40,
                        ),
                  SizedBox(height: 10.h),
                  InkWell(
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account?",
                        style: bodyStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.black20),
                        children: <TextSpan>[
                          TextSpan(
                              text: " Log in",
                              style: bodyStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.green20,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.login,
                                  );
                                }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const FooterPadding(),
            ],
          );
        },
      ),
    );
  }
}
