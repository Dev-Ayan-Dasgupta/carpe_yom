import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordCriteria extends StatelessWidget with TextStyleMixin {
  PasswordCriteria({
    Key? key,
    this.criteria1Color,
    this.criteria2Color,
    this.criteria3Color,
    this.criteria4Color,
    this.backgroundColor,
    this.criteria1Widget,
    this.criteria2Widget,
    this.criteria3Widget,
    this.criteria4Widget,
  }) : super(key: key);

  final Color? criteria1Color;
  final Color? criteria2Color;
  final Color? criteria3Color;
  final Color? criteria4Color;
  final Color? backgroundColor;

  final Widget? criteria1Widget;
  final Widget? criteria2Widget;
  final Widget? criteria3Widget;
  final Widget? criteria4Widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(3.w),
        ),
        color: backgroundColor ?? const Color(0xFFEEEEEE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password Criteria",
            style: headingStyle(
              color: AppColors.dark100,
              fontSize: 16.w,
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Minimum 8 characters",
                style: headingStyle(
                  color: criteria1Color ?? AppColors.red100,
                  fontSize: 14.w,
                ),
              ),
              criteria1Widget ?? const SizedBox(),
            ],
          ),
          SizedBox(height: 7.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Must contain one numeric value",
                style: headingStyle(
                  color: criteria2Color ?? AppColors.red100,
                  fontSize: 14.w,
                ),
              ),
              criteria2Widget ?? const SizedBox(),
            ],
          ),
          SizedBox(height: 7.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Must include upper and lower cases",
                style: headingStyle(
                  color: criteria3Color ?? AppColors.red100,
                  fontSize: 14.w,
                ),
              ),
              criteria3Widget ?? const SizedBox(),
            ],
          ),
          SizedBox(height: 7.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Must include one special character (!, @, #, ...)",
                style: headingStyle(
                  color: criteria4Color ?? AppColors.red100,
                  fontSize: 14.w,
                ),
              ),
              criteria4Widget ?? const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
