import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarFlexibleSpace extends StatelessWidget {
  const AppBarFlexibleSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.w),
          bottomRight: Radius.circular(25.w),
        ),
      ),
    );
  }
}
