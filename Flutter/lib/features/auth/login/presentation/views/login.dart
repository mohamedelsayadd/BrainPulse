import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Theming/text_style.dart';
import 'package:brain_pulse/core/Widgets/mybutton.dart';
import 'package:brain_pulse/core/helpers/spacing.dart';
import 'package:brain_pulse/features/app_navigation/app_navigation.dart';
import 'package:brain_pulse/features/auth/login/presentation/controller/cubit/login_cubit.dart';
import 'package:brain_pulse/features/auth/login/presentation/controller/cubit/login_state.dart';
import 'package:brain_pulse/features/auth/login/presentation/views/ui/widgets/lowerDesignLogin.dart';
import 'package:brain_pulse/features/auth/login/presentation/views/ui/widgets/pass_and_email_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    //bool isChecked = false;
    var read = context.read<LoginCubit>();
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is LoadedLoginSate) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AppNavigation()),
          (Route<dynamic> route) => false,
        );
      } else if (state is ErrorLoginState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errormsg)),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenSize.height * .13,
                horizontal: screenSize.height * .03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo-removebg-preview.png',
                    height: 140.h,
                    color: ColorsApp.primary,
                  ),
                  gapH(24),
                  Text(
                    'Welcome Back'.tr(),
                    style: TextStyleApp.font32wieght700ColorBlue.copyWith(
                      color: ColorsApp.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 30.sp,
                    ),
                  ),
                  gapH(20),

                  SizedBox(
                    height: screenSize.height * .04,
                  ),
                  const EmailAndPass(),
                  SizedBox(
                    height: screenSize.height * .02,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Checkbox(
                  //           value: isChecked,
                  //           onChanged: (_) {},
                  //         ),
                  //         Text('Remember me'.tr(),
                  //             style: TextStyleApp.font12weight400colorGrey),
                  //       ],
                  //     ),
                  //     Text('Forget Password?'.tr(),
                  //         style: TextStyleApp.font12weight400colorGrey
                  //             .copyWith(color: ColorsApp.primary)),
                  //   ],
                  // ),
                  SizedBox(
                    height: screenSize.height * .02,
                  ),
                  read.isloading == false
                      ? MyButton(
                          color: ColorsApp.primary,
                          onPressed: () {
                            if (read.loginkeyform.currentState!.validate()) {
                              read.loginvalidate();
                            }
                          },
                          text: 'Login'.tr(),
                        )
                      : TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(ColorsApp.primary),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: WidgetStateProperty.all(
                              const Size(double.infinity, 55),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                              ),
                            ),
                          ),
                          child: Center(
                            child: CupertinoActivityIndicator(
                              radius: 12.r,
                              animating: true,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: screenSize.height * .05,
                  ),
                  const Lowerdesignlogin(),
                  //   const loginBlocListener(),
                ],
              ),
            ),
          ));
    });
  }
}
