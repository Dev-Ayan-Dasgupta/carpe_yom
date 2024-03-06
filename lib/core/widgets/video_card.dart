// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCard extends StatelessWidget with TextStyleMixin {
  VideoCard({
    Key? key,
    required this.assetImage,
    required this.text,
    required this.controler,
  }) : super(key: key);

  final String assetImage;
  final String text;
  final String controler;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 150.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white,
        image:
            DecorationImage(image: AssetImage(assetImage), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(controler)),
                ],
              ),
            ),
            Text(
              text,
              style:
                  bodyStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
