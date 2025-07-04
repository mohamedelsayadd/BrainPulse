import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Theming/text_style.dart';
import 'package:brain_pulse/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create Account'.tr(),
          style: TextStyleApp.styleText(
            24.sp,
            ColorsApp.primary,
            FontWeight.bold,
          ),
        ),
        gapH(30)
        // const SizedBox(
        //   height: 10,
        // ),
        // Text(
        //   'Sign up now and start exploring all that our'.tr(),
        //   style:
        //       TextStyleApp.styleText(14, Colors.grey[700]!, FontWeight.normal),
        // ),
        // Text(
        //   'app has to offer. We're excited to welcome\nyou to our community!'.tr(),
        //   style:
        //       TextStyleApp.styleText(14, Colors.grey[700]!, FontWeight.normal),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
      ],
    );
  }
}
