import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Theming/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EegDataContainer extends StatelessWidget {
  const EegDataContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10.w),
      width: double.infinity.w,
      height: 400.h,
      decoration: BoxDecoration(
          color: ColorsApp.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                color: Colors.black54,
                blurRadius: 4,
                spreadRadius: 2)
          ]),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            'EEG Result'.tr(),
            style: TextStyleApp.font22weight400colorRed.copyWith(
                color: ColorsApp.primary, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(right: 198.0.w, top: 30.h),
            child: Text(
              'EEG Id: 87644'.tr(),
              style: TextStyleApp.font18weight400colorRed
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 120.0.w, top: 15.h),
            child: Text(
              'Seizure Vote: 0.087644'.tr(),
              style: TextStyleApp.font18weight400colorRed
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 155.0.w, top: 15.h),
            child: Text(
              'Ipd Vote: 0.087644'.tr(),
              style: TextStyleApp.font18weight400colorRed
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 155.0.w, top: 15.h),
            child: Text(
              'Gpd Vote: 0.087644'.tr(),
              style: TextStyleApp.font18weight400colorRed
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 155.0.w, top: 15.h),
            child: Text(
              'Irda Vote: 0.087644'.tr(),
              style: TextStyleApp.font18weight400colorRed
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 150.0.w, top: 15.h),
            child: Text(
              'Grda Vote: 0.087644'.tr(),
              style: TextStyleApp.font18weight400colorRed
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 140.0.w, top: 15.h),
            child: Text(
              'Other Vote: 0.087644'.tr(),
              style: TextStyleApp.font18weight400colorRed
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
