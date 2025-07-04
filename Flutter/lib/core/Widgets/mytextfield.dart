import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Theming/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.showText,
    required this.hint,
    this.icon,
    this.controller,
    required this.validator,
    this.keyboardType,
  });
  final bool? showText;
  final String? hint;
  final Widget? icon;
  final TextEditingController? controller;
  final Function(String?) validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: showText ?? false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: ColorsApp.primary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        hintText: hint,
        hintStyle: TextStyleApp.styleText(15, Colors.grey, FontWeight.normal),
        suffixIcon: icon,
        fillColor: const Color(0xffFDFDFF),
      ),
      validator: (value) {
        return validator(value);
      },
    );
  }
}
