import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientButton extends StatefulWidget {
  const GradientButton({
    Key? key,
    required this.onTap,
    this.width,
    this.height,
    this.borderRadius,
    this.gradient,
    required this.text,
    this.auxWidget,
    this.fontColor,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  final VoidCallback onTap;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Gradient? gradient;
  final String text;
  final Widget? auxWidget;
  final Color? fontColor;

  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> with TextStyleMixin {
  bool isBeingTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleEnd: (details) {
        setState(() {
          isBeingTapped = false;
        });
      },
      onTapUp: (value) async {
        await Future.delayed(const Duration(milliseconds: 100));
        if (mounted) {
          setState(() {
            isBeingTapped = false;
          });
        }
      },
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: widget.width ?? 428.w,
        height: widget.height ?? 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.borderRadius ?? 10.sp,
            ),
          ),
          color: isBeingTapped ? AppColors.primary : AppColors.primary,
          image: isBeingTapped
              ? null
              : const DecorationImage(
                  image: AssetImage(ImageConstants.buttonGradient),
                  fit: BoxFit.fill,
                ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.text, style: buttonStyle()),
              widget.auxWidget ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
