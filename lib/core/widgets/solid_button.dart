import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SolidButton extends StatelessWidget with TextStyleMixin {
  SolidButton({
    Key? key,
    required this.onTap,
    this.width,
    this.height,
    this.borderColor,
    this.borderRadius,
    this.boxShadow,
    this.color,
    this.auxWidget,
    required this.text,
    this.fontColor,
    this.borderWidth,
    this.fontSize,
  }) : super(key: key);

  final VoidCallback onTap;
  final double? width;
  final double? height;
  final Color? borderColor;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Color? color;
  final Widget? auxWidget;
  final String text;
  final Color? fontColor;
  final double? borderWidth;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 428.w,
        height: height ?? 50.h,
        decoration: BoxDecoration(
          border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 1),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? 10.w),
          ),
          boxShadow: boxShadow ?? [],
          color: color ?? AppColors.grey60,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                auxWidget ?? const SizedBox(),
                Text(
                  text,
                  style: buttonStyle(
                    color: fontColor ?? AppColors.green20,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
