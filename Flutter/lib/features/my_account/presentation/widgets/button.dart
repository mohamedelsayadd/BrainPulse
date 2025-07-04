import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonAcc extends StatelessWidget {
  const CustomButtonAcc({
    required this.color,
    required this.text,
    required this.onTap,
    super.key,
    this.textColor,
    this.textSized,
    this.withBorder,
    this.icon,
    this.iconWidget,
  });
  final Color color;
  final Color? textColor;
  final double? textSized;
  final String text;
  final void Function()? onTap;
  final bool? withBorder;
  final bool? icon;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: withBorder ?? true
                ? BorderSide(
                    color: textColor ?? Colors.white,
                  )
                : BorderSide.none,
          ),
        ),
        child: icon ?? false
            ? Row(
                spacing: 10.w,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconWidget ?? const SizedBox.shrink(),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: textSized ?? 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: textSized ?? 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
      ),
    );
  }
}
