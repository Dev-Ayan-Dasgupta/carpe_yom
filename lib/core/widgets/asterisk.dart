import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Asterisk extends StatelessWidget {
  const Asterisk({
    Key? key,
    this.color,
    this.fontSize,
  }) : super(key: key);

  final Color? color;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      " *",
      style: TextStyle(
        color: color ?? AppColors.red90,
        fontSize: 16.w,
      ),
    );
  }
}
