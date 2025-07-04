import 'package:easy_localization/easy_localization.dart';

import 'dart:developer';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:defer_pointer/defer_pointer.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({
    super.key,
  });

  Future<void> _launchUrl() async {
    log("here");
    if (!await launchUrl(Uri.parse(
        'https://www.acns.org/UserFiles/file/ACNSStandardizedCriticalCareEEGTerminology_rev2021.pdf'))) {
      return log('Could not launch ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            width: double.infinity,
            height: 190.h,
            decoration: BoxDecoration(
              color: ColorsApp.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.all(
                Radius.circular(30.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapH(30),
                Text(
                  'Discover a new way\nto read the brain'.tr(),
                  style: TextStyle(
                    color: ColorsApp.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                gapH(25),
                DeferPointer(
                  child: ElevatedButton(
                    onPressed: () {
                      _launchUrl();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsApp.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      'ACNS GUIDELINE'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 58.h,
            right: context.locale.languageCode == 'en' ? 3.w : 182.w,
            child: CircleAvatar(
              radius: 72.r,
              backgroundColor: Colors.white,
            ),
          ),
          Positioned(
            top: 18.h,
            right: context.locale.languageCode == 'en' ? 2.w : 180.w,
            child: Image.asset(
              'assets/images/information_card.png',
              width: 300.w,
              height: 200.h,
            ),
          )
        ],
      ),
    );
  }
}
