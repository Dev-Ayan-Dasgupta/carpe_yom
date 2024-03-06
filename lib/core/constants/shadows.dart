import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxShadows {
  static BoxShadow primary = BoxShadow(
    color: const Color.fromRGBO(0, 0, 0, 0.1),
    offset: Offset(4.w, 4.w),
    blurRadius: 5,
  );

  static BoxShadow primaryInverted = BoxShadow(
    color: const Color.fromRGBO(0, 0, 0, 0.1),
    offset: Offset(-4.w, -4.w),
    blurRadius: 5,
  );
}
