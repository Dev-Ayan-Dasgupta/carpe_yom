// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:carpeyom/core/constants/index.dart';

class CheckBoxWithMessage extends StatelessWidget with TextStyleMixin {
  CheckBoxWithMessage({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData? icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1.sp, color: AppColors.black80),
              borderRadius: BorderRadius.all(Radius.circular(5.sp))),
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: Icon(
                icon,
                color: AppColors.green70,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            text,
            style: bodyStyle(
              color: AppColors.dark50,
            ),
          ),
        ),
      ],
    );
  }
}
