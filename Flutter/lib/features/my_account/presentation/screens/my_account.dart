import 'package:brain_pulse/features/my_account/presentation/screens/change_lang_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:brain_pulse/core/widgets/gap.dart';
import 'package:brain_pulse/features/auth/login/presentation/controller/cubit/login_cubit.dart';
import 'package:brain_pulse/features/my_account/presentation/widgets/card_item_in_my_account.dart';
import 'package:brain_pulse/features/my_account/presentation/widgets/image_and_background_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  String? doctorName;

  @override
  void initState() {
    super.initState();
    loadDoctorName();
  }

  Future<void> loadDoctorName() async {
    final cubit = context.read<LoginCubit>();
    await cubit.loadUserDataFromPrefs();
    setState(() {
      doctorName = cubit.username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  await context.pushNamed('/EditProfileScreen');
                  await loadDoctorName();
                },
                child: const ImageAndBackgroundBar(
                  background: 'assets/images/background.png',
                  image: 'assets/images/OO6PT80.jpeg',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'DR: ${doctorName ?? "loading..."}'.tr(),
                      style: TextStyle(
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : const Color(0xFF1D2035)),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const GapH(height: 18),
                    Divider(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    const GapH(height: 24),
                    CardItemInMyAccount(
                      icon: 'assets/svgs/user-pen.svg',
                      title: 'Edit Profile'.tr(),
                      subTitle: 'Edit . Name . Email'.tr(),
                      onTap: () async {
                        await context.pushNamed('/EditProfileScreen');
                        await loadDoctorName();
                      },
                    ),
                    CardItemInMyAccount(
                      icon: 'assets/svgs/shield-check.svg',
                      title: 'Privacy and Security'.tr(),
                      subTitle: 'Change your password . Personal data '.tr(),
                      onTap: () {
                        context.pushNamed('/PrivacyAndSecurity');
                      },
                    ),
                    // CardItemInMyAccount(
                    //   icon: 'assets/svgs/dark-theme-svgrepo-com.svg',
                    //   //colorBackgroundIcon: ColorsApp.primary,
                    //   colorsvg: ColorsApp.primary,
                    //   title: 'Theme Mode'.tr(),
                    //   subTitle: 'Dark , Light Mode '.tr(),
                    //   onTap: () {
                    //     context.pushNamed('/themedata');
                    //   },
                    // ),
                    CardItemInMyAccountImage(
                      icon: 'assets/images/language.png',
                      title: 'Language'.tr(),
                      subTitle: 'Change app language '.tr(),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ChangeLangScreen();
                          },
                        ));
                      },
                    ),
                    CardItemInMyAccount(
                      icon: 'assets/svgs/message-circle-question.svg',
                      title: 'Help Center'.tr(),
                      subTitle: 'technical support'.tr(),
                      onTap: () async {
                        final phone = '201024112206'.tr();
                        final message =
                            Uri.encodeComponent('Hello, I need help!!!!!'.tr());
                        final url =
                            Uri.parse("https://wa.me/$phone?text=$message");

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Error, Please try again later'.tr()),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
