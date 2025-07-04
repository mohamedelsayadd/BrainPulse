import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/text_style.dart';
import 'package:brain_pulse/core/Widgets/mytextfield.dart';
import 'package:brain_pulse/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowTextWithTextFieldGetDataByDoctor extends StatelessWidget {
  const RowTextWithTextFieldGetDataByDoctor({
    super.key,
    required this.number,
    required this.controller,
  });
  final String number;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ' point $number :'.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        gapW(20),
        SizedBox(
          width: 80.w,
          height: 40.h,
          child: MyTextField(
            controller: controller,
            keyboardType: TextInputType.number,
            hint: '0'.tr(),
            validator: (p0) {},
          ),
        ),
      ],
    );
  }
}
