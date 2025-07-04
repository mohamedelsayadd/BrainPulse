import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:brain_pulse/core/helpers/shared_pref_helper/shared_pref_helper.dart';
import 'package:brain_pulse/core/widgets/gap.dart';
import 'package:brain_pulse/features/my_account/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 500.h,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: Column(
          children: <Widget>[
            const GapH(height: 10),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const GapH(height: 7),
            Container(
              width: 130.w,
              height: 130.h,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 180, 12, 0),
                borderRadius: BorderRadius.all(
                  Radius.circular(555.r),
                ),
              ),
              child: SvgPicture.asset(
                'assets/svgs/circle-information.svg',
                fit: BoxFit.scaleDown,
              ),
            ),
            const GapH(height: 20),
            Text(
              'Logout'.tr(),
              style: TextStyle(
                color: const Color(0xFF2B2F4E),
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            const GapH(height: 16),
            SizedBox(
              height: 71.h,
              child: Text(
                textAlign: TextAlign.center,
                'Are you sure you want to log out? Your current session will be terminated and you won\'t be able to access your account until you log in again.'
                    .tr(),
                style: TextStyle(
                  color: const Color(0xFF637D92),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const GapH(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 160.w,
                  height: 60.h,
                  child: CustomButtonAcc(
                    color: Colors.white,
                    textColor: const Color.fromARGB(
                      255,
                      180,
                      12,
                      0,
                    ),
                    text: 'Logout'.tr(),
                    onTap: () async {
                      await SharedPrefHelper.clearAllData();
                      context.pushNamedAndRemoveUntil('/loginScreen',
                          predicate: (Route<dynamic> route) => false);
                    },
                  ),
                ),
                SizedBox(
                  width: 160.w,
                  height: 60.h,
                  child: CustomButtonAcc(
                    color: ColorsApp.primary,
                    text: 'Stay'.tr(),
                    onTap: () {
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
