import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTile extends StatelessWidget with TextStyleMixin {
  DetailsTile({
    Key? key,
    required this.length,
    required this.details,
    this.coloredIndex,
    required this.boldIndices,
    this.fontColor,
  }) : super(key: key);

  final int length;
  final List<DetailsTileModel> details;
  final int? coloredIndex;
  final List<int> boldIndices;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: length,
          itemBuilder: (context, index) {
            return Container(
              width: 428.w,
              height: 40.h,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: index == 0
                      ? BorderSide(color: AppColors.green10, width: 1.sp)
                      : BorderSide.none,
                  bottom: (index == length - 1)
                      ? BorderSide(color: AppColors.green10, width: 1.sp)
                      : BorderSide.none,
                  left: BorderSide(color: AppColors.green10, width: 1.sp),
                  right: BorderSide(color: AppColors.green10, width: 1.sp),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: (index == 0)
                      ? Radius.circular(10.w)
                      : const Radius.circular(0),
                  topRight: (index == 0)
                      ? Radius.circular(10.w)
                      : const Radius.circular(0),
                  bottomLeft: (index == length - 1)
                      ? Radius.circular(10.w)
                      : const Radius.circular(0),
                  bottomRight: (index == length - 1)
                      ? Radius.circular(10.w)
                      : const Radius.circular(0),
                ),
                color: (index % 2 != 0) ? Colors.white : AppColors.black10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    details[index].key,
                    style: bodyStyle(
                      color: AppColors.blackSecondary,
                      fontSize: 14.sp,
                      fontWeight: (boldIndices.contains(index))
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      details[index].value,
                      style: bodyStyle(
                        color: (index == coloredIndex)
                            ? fontColor
                            : AppColors.blackSecondary,
                        fontSize: 14.sp,
                        fontWeight: (boldIndices.contains(index))
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class DetailsTileModel {
  final String key;
  final String value;
  DetailsTileModel({
    required this.key,
    required this.value,
  });
}
