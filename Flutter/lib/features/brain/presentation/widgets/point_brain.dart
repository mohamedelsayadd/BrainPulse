import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PointInBrain extends StatelessWidget {
  const PointInBrain({
    super.key,
    required this.num,
  });
  final String num;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: ColorsApp.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(555.r),
      ),
      child: Center(
        child: Text(
          num,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class PointInBrainInfo extends StatelessWidget {
  const PointInBrainInfo({super.key, required this.colorIcon});
  final Color colorIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: colorIcon,
        borderRadius: BorderRadius.circular(555.r),
      ),
    );
  }
}
