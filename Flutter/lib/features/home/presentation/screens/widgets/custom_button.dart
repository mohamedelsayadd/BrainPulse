import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Theming/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.text,
    required this.width,
    required this.height,
    this.color,
    this.borderColor,
    this.textColor,
  });
  final void Function()? onTap;
  final String text;
  final double width;
  final double height;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: borderColor ?? Colors.white,
          ),
          color: color ?? ColorsApp.grey,
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyleApp.font16weight600colorGrey.copyWith(
            color: textColor ??
                (Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color(0xFF1D2035)),
          ),
        )),
      ),
    );
  }
}
