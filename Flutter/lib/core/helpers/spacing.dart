import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox gapH(double height) {
  return SizedBox(
    height: height.h,
  );
}

SizedBox gapW(double width) {
  return SizedBox(
    width: width.h,
  );
}

SizedBox gapWH(double x, double y) {
  return SizedBox(
    height: y.h,
    width: x.w,
  );
}
