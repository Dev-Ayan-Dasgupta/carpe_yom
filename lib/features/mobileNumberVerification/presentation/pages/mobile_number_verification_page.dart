import 'dart:developer';
import 'package:carpeyom/config/routes/routes.dart';
import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/mobileNumberVerification/domain/entities/mobile_number_verification_argument.dart';
import 'package:carpeyom/features/mobileNumberVerification/presentation/bloc/addmobilenumberbloc/add_mobile_number_bloc.dart';
import 'package:carpeyom/features/mobileNumberVerification/presentation/bloc/addmobilenumberbloc/add_mobile_number_event.dart';
import 'package:carpeyom/features/mobileNumberVerification/presentation/bloc/addmobilenumberbloc/add_mobile_number_state.dart';
import 'package:carpeyom/features/otpVerification/domain/entities/otp_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MobileNumberVerificationPage extends StatefulWidget {
  const MobileNumberVerificationPage({
    Key? key,
    this.argument,
  }) : super(key: key);

  final Object? argument;

  @override
  State<MobileNumberVerificationPage> createState() =>
      _MobileNumberVerificationPageState();
}

class _MobileNumberVerificationPageState
    extends State<MobileNumberVerificationPage> with TextStyleMixin {
  late MobileNumberVerificationArgumentEntity verifyMobileArgumentEntity;
  final TextEditingController _phoneController = TextEditingController();

  String? selectedIsd = "+971";
  Color borderColor = const Color(0xFFEEEEEE);

  @override
  void initState() {
    super.initState();
    verifyMobileArgumentEntity = MobileNumberVerificationArgumentEntity.fromMap(
        widget.argument as dynamic ?? {});
  }

  @override
  Widget build(BuildContext context) {
    log("Widget build called in verify mobile");
    return Scaffold(
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
          "Almost there",
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: BlocBuilder<AddMobileNumberBloc, AddMobileNumberState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),

                      Text(
                        "Enter your mobile number",
                        style: headingStyle(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "This mobile number will be used as your primary contact and for verification purposes during account creation.",
                        style: bodyStyle(
                            fontSize: 14.w,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black20),
                      ),
                      SizedBox(height: 20.h),

                      CustomTextField(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Mobile Number",
                              style: hintStyle(
                                fontSize: 12.w,
                                fontWeight: FontWeight.w500,
                                color: AppColors.dark80,
                              ),
                            ),
                            const Asterisk(),
                          ],
                        ),
                        borderColor: borderColor,
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                ImageConstants.flag,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: Text(
                                "+971",
                                style: hintStyle(color: AppColors.black80),
                              ),
                            ),
                            SizedBox(
                              height: 19.h,
                              child: const VerticalDivider(
                                  thickness: 1, color: AppColors.black5),
                            ),
                          ],
                        ),
                        hintText: "Mobile Number",
                        focussedBorderColor:
                            state is AddMobileNumberSuccessState
                                ? AppColors.black100
                                : state is AddMobileNumberErrorState
                                    ? AppColors.red90
                                    : AppColors.black5,
                        suffixIcon: state is AddMobileNumberSuccessState
                            ? Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: SvgPicture.asset(
                                  ImageConstants.checkCircle,
                                  width: 20.w,
                                  height: 20.w,
                                ),
                              )
                            : state is AddMobileNumberErrorState
                                ? Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: InkWell(
                                      onTap: () {
                                        _phoneController.clear();
                                      },
                                      child: SvgPicture.asset(
                                        ImageConstants.deleteText,
                                        width: 17.w,
                                        height: 17.w,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                        onChanged: checkPhoneNumber,
                      ),
                      //   },
                      // ),
                      SizedBox(height: 9.h),
                      state is AddMobileNumberErrorState
                          ? Row(
                              children: [
                                SizedBox(height: 20.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: SvgPicture.asset(
                                    ImageConstants.warningText,
                                    height: 14.h,
                                    width: 14.w,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    "Invalid mobile number",
                                    style: bodyStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.w,
                                        color: AppColors.red90),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                Column(
                  children: [
                    state is AddMobileNumberSuccessState
                        ? GradientButton(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.otp,
                                arguments: OTPArgumentEntity(
                                  emailOrPhone:
                                      "$selectedIsd${_phoneController.text}",
                                  isEmail: false,
                                  isBusiness: false,
                                  isInitial: true,
                                  isLogin: false,
                                  isEmailIdUpdate: false,
                                  isMobileUpdate: true,
                                  isReKyc: false,
                                ).toMap(),
                              );
                            },
                            text: "Proceed",
                            // auxWidget: state is LoginLoading
                            //     ? const LoaderRow()
                            //     : const SizedBox(),
                          )
                        : SolidButton(onTap: () {}, text: "Proceed"),
                    SizedBox(height: 10.h),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void checkPhoneNumber(String p0) {
    context.read<AddMobileNumberBloc>().add(EnterMobileEvent(mobile: p0));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
