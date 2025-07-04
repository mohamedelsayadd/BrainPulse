import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Onboarding.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 80),
                  Image.asset(
                    'assets/images/onboard22.png',
                    height: 230.h,
                  ),
                  const SizedBox(height: 45),
                  SizedBox(
                    child: Text(
                      'We are here to help you'.tr(),
                      style: TextStyle(
                        color: const Color(0xFF1D2035),
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 350.w,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Analyze symptoms and medical reports with advanced artificial intelligence.'
                          .tr(),
                      style: TextStyle(
                        color: const Color(0xFF637D92),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
