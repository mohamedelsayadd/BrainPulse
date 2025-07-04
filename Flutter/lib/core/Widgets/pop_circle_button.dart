import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopCircleButton extends StatelessWidget {
  const PopCircleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        width: 70.w,
        height: 70.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(555.r),
          border: Border.all(color: Colors.grey),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Colors.grey,
          ),
        ),
      ),
      onPressed: () {
        context.pop();
      },
    );
  }
}
