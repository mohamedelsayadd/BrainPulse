import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class textFieldCustom extends StatelessWidget {
  textFieldCustom(
      {super.key,
      this.hintText,
      this.iconS,
      this.iconP,
      this.obscureText,
      this.enable,
      this.hintColor,
      this.keyboardType,
      this.controller,
      this.validator,
      this.textDirection});

  final String? hintText;
  final TextDirection? textDirection;
  final Widget? iconS;
  final Widget? iconP;
  final bool? obscureText;
  final bool? enable;
  final Color? hintColor;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: textDirection,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      enabled: enable ?? true,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: SizedBox(child: iconP ?? const SizedBox.shrink()),
        suffixIcon: SizedBox(child: iconS ?? const SizedBox.shrink()),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor ?? const Color(0xFFAAB9C5),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFE7EBEF),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE7EBEF),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE7EBEF),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE7EBEF),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
      ),
    );
  }
}

class TextFieldMaxLineCustom extends StatelessWidget {
  const TextFieldMaxLineCustom({
    super.key,
    this.hintText,
    this.iconS,
    this.iconP,
    this.obscureText,
    this.enable,
    this.hintColor,
    this.keyboardType,
    this.controller,
    this.maxLine,
    this.minLine,
  });

  final String? hintText;

  final Widget? iconS;
  final Widget? iconP;
  final bool? obscureText;
  final bool? enable;
  final Color? hintColor;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final int? maxLine;
  final int? minLine;
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLine ?? 7,
      minLines: minLine ?? 7,
      controller: controller,
      keyboardType: keyboardType,
      enabled: enable ?? true,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor ?? const Color(0xFFAAB9C5),
          fontSize: 16.sp,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFE7EBEF),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE7EBEF),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE7EBEF),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
      ),
    );
  }
}
