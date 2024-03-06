import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class CustomPinput extends StatefulWidget {
  const CustomPinput({
    Key? key,
    required this.pinController,
    this.borderColor,
    required this.onChanged,
    this.enabled,
  }) : super(key: key);

  final TextEditingController pinController;
  final Color? borderColor;

  final Function(String) onChanged;
  final bool? enabled;

  @override
  State<CustomPinput> createState() => _CustomPinputState();
}

class _CustomPinputState extends State<CustomPinput> with TextStyleMixin {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      autofocus: true,
      length: 6,
      controller: widget.pinController,
      defaultPinTheme: PinTheme(
        width: 45.w,
        height: 45.w,
        textStyle: bodyStyle(
          fontSize: 22.w,
          fontWeight: FontWeight.w400,
          color: AppColors.black30,
        ),
        decoration: BoxDecoration(
          border:
              Border.all(color: widget.borderColor ?? const Color(0xFFE8E6EA)),
          borderRadius: BorderRadius.all(
            Radius.circular(10.w),
          ),
          color: Colors.transparent,
        ),
      ),
      onChanged: widget.onChanged,
      enabled: widget.enabled ?? true,
    );
  }
}
