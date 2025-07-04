import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:brain_pulse/core/routing/routers.dart';
import 'package:brain_pulse/features/home/presentation/screens/widgets/custom_button.dart';
import 'package:brain_pulse/features/onboarding/presentation/screens/onboarding1.dart';
import 'package:brain_pulse/features/onboarding/presentation/screens/onboarding2.dart';
import 'package:brain_pulse/features/onboarding/presentation/widgets/animated_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (int value) {
              setState(() {
                _currentPage = value;
              });
            },
            controller: _pageController,
            children: const <Widget>[
              Onboarding1(),
              Onboarding2(),
            ],
          ),
          if (_currentPage == 0)
            Positioned(
              top: 50.h,
              left: 24.w,
              child: SizedBox(
                width: 70.w,
                height: 38.h,
                child: CustomButton(
                  width: 75.w,
                  height: 40.h,
                  textColor: const Color(0xFF07929A),
                  color: Colors.transparent,
                  text: 'skip'.tr(),
                  onTap: () {
                    context.pushNamed(Routes.loginScreen);
                  },
                ),
              ),
            )
          else
            const SizedBox.shrink(),
          Positioned(
            top: 680.h,
            left: 160.w,
            child: Row(
              children: <Widget>[
                AnimatedContainerOnBoarding(
                  active: _currentPage == 0,
                ),
                SizedBox(width: 5.w),
                AnimatedContainerOnBoarding(
                  active: _currentPage == 1,
                ),
                SizedBox(width: 5.w),
              ],
            ),
          ),
          Positioned(
            top: 710.h,
            left: 15.w,
            child: SizedBox(
              width: 350.w,
              child: CustomButton(
                width: 350.w,
                height: 50.h,
                color: const Color(0xFF0CAFB4),
                text: _currentPage == 0
                    ? 'I want to know more'.tr()
                    : 'Let\'s go'.tr(),
                onTap: () {
                  _pageController.animateToPage(
                    _currentPage + 1,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.linear,
                  );
                  _currentPage == 1
                      ? context.pushNamed(Routes.loginScreen)
                      : null;
                },
              ),
            ),
          ),
          Positioned(
            top: 800.h,
            left: 15.w,
            child: Container(
              color: Colors.white,
              width: 375.w,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
