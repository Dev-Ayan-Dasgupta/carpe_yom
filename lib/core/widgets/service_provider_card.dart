import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceProviderCard extends StatelessWidget with TextStyleMixin {
  final String title;
  final Color? bgColor;
  final Color? fontColor;
  ServiceProviderCard(
      {Key? key, required this.title, this.bgColor, this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: bgColor ?? AppColors.grey70,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: headingStyle(
              fontSize: 12.w,
              fontWeight: FontWeight.w500,
              color: fontColor ?? AppColors.black40),
        ),
      ),
    );
  }
}
