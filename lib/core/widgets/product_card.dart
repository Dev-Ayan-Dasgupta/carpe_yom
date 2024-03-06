// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget with TextStyleMixin {
  ProductCard({
    Key? key,
    required this.assetName,
    required this.text,
  }) : super(key: key);

  final String assetName;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 93.w,
      decoration: BoxDecoration(
        boxShadow: [BoxShadows.primary],
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: SvgPicture.asset(
              assetName,
              width: 23.w,
              height: 23.w,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: bodyStyle(
              fontSize: 12.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black20,
            ),
          ),
        ],
      ),
    );
  }
}
