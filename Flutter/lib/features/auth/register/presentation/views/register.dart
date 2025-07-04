import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Widgets/gap.dart';
import 'package:brain_pulse/core/Widgets/mybutton.dart';
import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:brain_pulse/features/auth/register/presentation/controller/cubit/register_cubit.dart';
import 'package:brain_pulse/features/auth/register/presentation/controller/cubit/register_state.dart';
import 'package:brain_pulse/features/auth/register/presentation/views/widgets/pass_and_email_register.dart';
import 'package:brain_pulse/features/auth/register/presentation/views/widgets/top_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key, this.ontap});
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    var read = context.read<RegisterCubit>();

    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
      if (state is LoadedRegisterState) {
        Navigator.pop(context);
      } else if (state is FailuerRegisterState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errormsg)),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const TopPage(),
              const PassAndEmail(),
              const GapH(
                height: 15,
              ),
              read.isLoading == false
                  ? MyButton(
                      onPressed: () {
                        if (read.registerkeyform.currentState!.validate()) {
                          return read.registervalidate();
                        }
                        read.confirmpasswordValidate();
                      },
                      text: 'Create Account'.tr(),
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
              const GapH(
                height: 30,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: Color(0xffe0e0e0),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      'Or sign in with'.tr(),
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Color(0xffe0e0e0),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const GapH(
                height: 10,
              ),

              // const TermsAndConditions(),
              const GapH(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an Account. '.tr(),
                      style: Theme.of(context).textTheme.bodySmall),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Text(
                      'SignIn'.tr(),
                      style: TextStyle(
                        color: ColorsApp.primary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  // validatToRegister(BuildContext context) {
  //   if (context.read<RegisterCubit>().formKey.currentState!.validate()) {
  //     context.read<RegisterCubit>().emitRegisterStates();
  //   }
  // }
}
