import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/routing/routers.dart';
import 'package:brain_pulse/features/auth/login/presentation/controller/cubit/login_cubit.dart';
import 'package:brain_pulse/features/auth/login/presentation/controller/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    super.initState();
    splash();
    context.read<LoginCubit>().checkLoginStatus();
  }

  splash() {
    Future.delayed(const Duration(seconds: 2), () {
      if (context.read<LoginCubit>().state is LoadedLoginSate) {
        Navigator.pushReplacementNamed(context, Routes.appNavigation);
      } else {
        Navigator.pushReplacementNamed(context, Routes.onBoarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.white,
        body: Stack(
          children: [
            Image.asset('assets/images/Splash_Screen.png'),
            Positioned(
              top: 330.h,
              left: 110.w,
              child: Column(
                spacing: 10.h,
                children: [
                  Image.asset(
                    'assets/images/logo-removebg-preview.png',
                    color: Colors.white,
                    height: 120.h,
                  ),
                  Text(
                    'Brain Pulse',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 32.sp,
                    ),
                  ),
                ],),
            ),],
        ));}
}
