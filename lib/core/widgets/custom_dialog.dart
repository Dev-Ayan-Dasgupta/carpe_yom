import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDialog extends StatelessWidget with TextStyleMixin {
  CustomDialog({
    Key? key,
    required this.svgAssetPath,
    required this.title,
    required this.message,
    required this.widget,
  }) : super(key: key);

  final String svgAssetPath;
  final String title;
  final String message;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: Container(
              width: 396.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(24.w),
                ),
                color: Colors.white,
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      SvgPicture.asset(
                        svgAssetPath,
                        width: 160.w,
                        height: 155.h,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        title,
                        style: headingStyle(
                            fontSize: 22.w, color: AppColors.black30),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 50.w, right: 50.w),
                        child: Text(
                          message,
                          style: bodyStyle(color: AppColors.black100),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      widget,
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
