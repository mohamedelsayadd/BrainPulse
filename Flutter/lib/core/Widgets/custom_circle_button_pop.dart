import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleButtonPop extends StatelessWidget {
  const CustomCircleButtonPop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            size: 25.sp,
            Icons.arrow_back_ios_new,
            color: Theme.of(context).appBarTheme.iconTheme?.color,
          ),
        ),
      ),
    );
  }
}
