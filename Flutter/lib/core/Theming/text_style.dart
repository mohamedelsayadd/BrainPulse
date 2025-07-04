import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleApp {
  static TextStyle styleText(double size, Color color, FontWeight fw) {
    return GoogleFonts.poppins(color: color, fontSize: size.sp, fontWeight: fw);
  }

  static TextStyle logoText = TextStyle(
      fontSize: 20,
      fontFamily: 'Inter',
      fontWeight: FontWeight.bold,
      color: ColorsApp.grey600);

  static TextStyle font32wieght700ColorBlue = TextStyle(
    fontSize: 32.sp,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    height: 0.05,
    color: ColorsApp.blue,
  );

  static TextStyle Button_Style = TextStyle(
    color: ColorsApp.white,
    fontSize: 16.sp,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );
  static TextStyle font14weight400colorGrey = TextStyle(
    color: ColorsApp.grey,
    fontSize: 14.sp,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
  static TextStyle font16weight600colorGrey = TextStyle(
    color: ColorsApp.grey,
    fontSize: 16.sp,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );
  static TextStyle font12weight400colorGrey = TextStyle(
    color: ColorsApp.grey,
    fontSize: 12.sp,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
  static TextStyle font22weight400colorRed = TextStyle(
    color: ColorsApp.darkRed,
    fontSize: 22.sp,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
  static TextStyle font22weightBoldColorRed = TextStyle(
    color: ColorsApp.darkRed,
    fontSize: 22.sp,
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
  );
  static TextStyle font18weight400colorRed = TextStyle(
    color: ColorsApp.darkRed,
    fontSize: 18.sp,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
  static TextStyle font18boldBlack = TextStyle(
    color: ColorsApp.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16weight600colorBlack = TextStyle(
    color: ColorsApp.black,
    fontSize: 16.sp,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );
  static TextStyle font18weight600colorBlack = TextStyle(
    color: ColorsApp.black,
    fontSize: 18.sp,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );
}
