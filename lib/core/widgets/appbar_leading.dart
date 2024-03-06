import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarLeading extends StatelessWidget {
  const AppBarLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          ImageConstants.backButton,
          height: 20.h,
          width: 20.w,
        ),
      ),
    );
  }
}
