import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

RoundedRectangleBorder appBarShape() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25.w),
      bottomRight: Radius.circular(25.w),
    ),
  );
}
