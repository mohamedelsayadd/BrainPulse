import 'package:easy_localization/easy_localization.dart';

import 'dart:async';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/features/brain/presentation/screens/brain_screen.dart';
import 'package:brain_pulse/features/history/presentation/screens/history.dart';
import 'package:brain_pulse/features/home/presentation/screens/home_screen.dart';
import 'package:brain_pulse/features/my_account/presentation/screens/my_account.dart';
import 'package:brain_pulse/offline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const BrainScreen(),
    const History(),
    const MyAccount(),
  ];
  bool offline = true;
  StreamSubscription? _subscription;
  @override
  void initState() {
    _subscription = InternetConnection().onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        setState(() {
          offline = true;
        });
      } else {
        setState(() {
          offline = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        backgroundColor: ColorsApp.white,
        icon: SvgPicture.asset(
          'assets/svgs/home-2.svg',
          width: 24.w,
          color: Colors.grey,
        ),
        label: 'Home'.tr(),
        activeIcon: SvgPicture.asset(
          'assets/svgs/home-2.svg',
          width: 24.w,
          color: ColorsApp.primary,
        ),
      ),
      BottomNavigationBarItem(
        backgroundColor: ColorsApp.white,
        icon: Image.asset(
          'assets/images/brain_icon.png',
          width: 25.w,
          color: Colors.grey,
        ),
        label: 'Brain'.tr(),
        activeIcon: Image.asset(
          'assets/images/brain_icon.png',
          width: 25.w,
          color: ColorsApp.primary,
        ),
      ),
      BottomNavigationBarItem(
        backgroundColor: ColorsApp.white,
        icon: Image.asset(
          'assets/images/history_icon.png',
          width: 25.w,
          color: Colors.grey,
        ),
        label: 'History'.tr(),
        activeIcon: Image.asset(
          'assets/images/history_icon.png',
          width: 25.w,
          color: ColorsApp.primary,
        ),
      ),
      BottomNavigationBarItem(
        backgroundColor: ColorsApp.white,
        icon: const Icon(
          Icons.more_vert_outlined,
          color: Colors.grey,
          size: 28,
        ),
        label: 'More'.tr(),
        activeIcon: Icon(
          color: ColorsApp.primary,
          Icons.more_vert_outlined,
          size: 28,
        ),
      ),
    ];
    return offline
        ? Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: _children[_currentIndex],
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                selectedIconTheme: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedIconTheme,
                unselectedItemColor: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
                items: items,
                currentIndex: _currentIndex,
                selectedItemColor: ColorsApp.primary,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          )
        : OfflineScreen(onRetry: () {});
  }
}
