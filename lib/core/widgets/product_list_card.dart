import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListCard extends StatelessWidget with TextStyleMixin {
  final String img;
  final String name;
  final String earn;
  final String content;
  ProductListCard(
      {Key? key,
      required this.img,
      required this.name,
      required this.earn,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [BoxShadows.primary, BoxShadows.primaryInverted],
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              width: 130.w,
              height: 80.w,
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: headingStyle(
                  fontSize: 14.w,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              width: 155.w,
              padding: EdgeInsets.all(8.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.dark20),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                color: AppColors.green40,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Text(
                      "Earn:",
                      textAlign: TextAlign.center,
                      style: bodyStyle(
                          fontSize: 12.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black20),
                    ),
                  ),
                  Text(
                    earn,
                    textAlign: TextAlign.center,
                    style: bodyStyle(
                        fontSize: 12.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: 155.w,
              padding: EdgeInsets.all(10.w),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: AppColors.grey60,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Image.asset(ImageConstants.contentLead),
                  ),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: bodyStyle(
                        fontSize: 12.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey50),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
