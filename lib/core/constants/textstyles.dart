import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin TextStyleMixin {
  final String fontFamily = "Poppins";

  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  TextStyle appBarStyle(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      TextDecoration? decoration}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize ?? 16.sp,
      fontWeight: fontWeight ?? semiBold,
      color: color ?? AppColors.green20,
      decoration: decoration ?? TextDecoration.none,
    );
  }

  TextStyle headingStyle(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      TextDecoration? decoration}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize ?? 26.sp,
      fontWeight: fontWeight ?? semiBold,
      color: color ?? AppColors.black100,
      decoration: decoration ?? TextDecoration.none,
    );
  }

  TextStyle bodyStyle(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      TextDecoration? decoration}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize ?? 14.sp,
      fontWeight: fontWeight ?? regular,
      color: color ?? AppColors.black80,
      decoration: decoration ?? TextDecoration.none,
    );
  }

  TextStyle hintStyle(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      TextDecoration? decoration}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize ?? 14.sp,
      fontWeight: fontWeight ?? regular,
      color: color ?? AppColors.black40,
      decoration: decoration ?? TextDecoration.none,
    );
  }

  TextStyle buttonStyle(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      TextDecoration? decoration}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize ?? 16.sp,
      fontWeight: fontWeight ?? semiBold,
      color: color ?? Colors.white,
      decoration: decoration ?? TextDecoration.none,
    );
  }
}
