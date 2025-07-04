import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Theming/text_style.dart';
import 'package:brain_pulse/core/Widgets/custom_circle_button_pop.dart';
import 'package:brain_pulse/features/home/presentation/screens/widgets/custom_button.dart';
import 'package:brain_pulse/features/home/presentation/screens/widgets/eeg_data_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataEegBody extends StatelessWidget {
  DataEegBody({
    super.key,
  });
  // EegModel? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.h, right: 300.w),
            child: const CustomCircleButtonPop(),
          ),
          const EegDataContainer(),
          CustomButton(
            text: 'Save Result'.tr(),
            width: 150.w,
            height: 40.h,
            color: ColorsApp.primary,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        backgroundColor: ColorsApp.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                        title: Text(
                          'Do you want save result?'.tr(),
                          style: TextStyleApp.font16weight600colorBlack,
                          textAlign: TextAlign.center,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/images/data-folder.png",
                                height: 120.h),
                            SizedBox(height: 16.h),
                            Text(
                              'You can save this EEG analysis to a new or existing patient file.'
                                  .tr(),
                              style: TextStyleApp.font12weight400colorGrey,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    'Existing Patient'.tr(),
                                    style: TextStyleApp.font14weight400colorGrey
                                        .copyWith(color: ColorsApp.black),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsApp.primary,
                                    minimumSize: Size(100.w, 40.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'New Patient'.tr(),
                                    style: TextStyleApp.font14weight400colorGrey
                                        .copyWith(color: ColorsApp.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
            },
          )
        ],
      ),
    );
  }
}
