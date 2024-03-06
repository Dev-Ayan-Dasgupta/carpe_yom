// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.isDense,
    this.width,
    this.topPadding,
    this.bottomPadding,
    this.leftPadding,
    this.rightPadding,
    this.borderColor,
    this.borderRadius,
    this.color,
    required this.controller,
    this.enabled,
    this.fontColor,
    this.hintColor,
    this.helperColor,
    this.focussedBorderColor,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.label,
    this.obscureText,
    required this.onChanged,
    this.hintText,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.inputFormatters,
  }) : super(key: key);

  final bool? isDense; //
  final double? width;
  final double? topPadding;
  final double? bottomPadding;
  final double? leftPadding;
  final double? rightPadding;
  final Color? borderColor;
  final double? borderRadius;
  final Color? color;
  final TextEditingController controller;
  final bool? enabled;
  final Color? fontColor;
  final Color? hintColor;
  final Color? helperColor;
  final Color? focussedBorderColor; //
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? label;
  final bool? obscureText;
  final Function(String) onChanged;
  final String? hintText;
  final TextInputType? keyboardType; //
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters; //

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> with TextStyleMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 428.w,
      padding: EdgeInsets.only(
        left: widget.leftPadding ?? 0.w,
        right: widget.rightPadding ?? 0.w,
        top: widget.topPadding ?? 0.w,
        bottom: widget.bottomPadding ?? 0.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.borderColor ?? const Color(0xFFEEEEEE),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            widget.borderRadius ?? 10.w,
          ),
        ),
        color: widget.color ?? Colors.transparent,
      ),
      child: TextFormField(
        inputFormatters: widget.inputFormatters ?? [],
        controller: widget.controller,
        enabled: widget.enabled,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          label: widget.label,
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.focussedBorderColor ?? Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.black5),
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          isDense: widget.isDense ?? false,
          border: InputBorder.none,
          prefixIcon: widget.prefixIcon,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          prefix: widget.prefix,
          suffixIcon: widget.suffixIcon,
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          suffix: widget.suffix,
          hintText: widget.hintText ?? "",
          hintStyle: hintStyle(),
        ),
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14.w,
          fontWeight: FontWeight.w400,
          color: AppColors.dark80,
        ),
        obscureText: widget.obscureText ?? false,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType ?? TextInputType.text,
      ),
    );
  }
}
