import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:brain_pulse/core/helpers/shared_pref_helper/shared_pref_helper.dart';
import 'package:brain_pulse/core/helpers/shared_pref_helper/shared_pref_keys.dart';
import 'package:brain_pulse/core/helpers/spacing.dart';
import 'package:brain_pulse/core/widgets/gap.dart';
import 'package:brain_pulse/features/auth/login/presentation/views/login.dart';
import 'package:brain_pulse/features/my_account/presentation/widgets/button.dart';
import 'package:brain_pulse/features/my_account/presentation/widgets/text_field_custom.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/controller/cubit/deletedoctor/delete_doctor_cubit.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/controller/cubit/deletedoctor/delete_doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool isShow = false;
  bool activeBox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            transform: GradientRotation(7.9),
            colors: <Color>[
              Color.fromARGB(42, 252, 182, 182),
              Colors.white,
              Color.fromARGB(42, 252, 182, 182),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(555.r),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                      gapW(30.w),
                      Text('Delete account'.tr(),
                          style: const TextStyle(
                            color: Color(0xFF1D2035),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                  const GapH(height: 50),
                  SvgPicture.asset(
                    'assets/svgs/delete-acc.svg',
                    width: 150.w,
                    height: 150.h,
                  ),
                  const GapH(height: 18),
                  Row(
                    children: <Widget>[
                      Text(
                        'Warning: Your account will be permanently deleted'
                            .tr(),
                        style: TextStyle(
                          color: const Color(0xFFE32B3D),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Divider(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  Text(
                    'When you delete your account, you will permanently lose all your data, including your bookings, courses, and content. This process is irreversible. Make sure you want to delete your account before proceeding.'
                        .tr(),
                    style: TextStyle(
                      color: const Color(0xFF465064),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const GapH(height: 18),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Reason for deleting the account'.tr(),
                      hintStyle: TextStyle(
                        color: const Color(0xFFCED7DE),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: textFieldCustom(
                      obscureText: !isShow,
                      hintText: 'Enter password'.tr(),
                      iconP: IconButton(
                        icon: IconButton(
                          icon: SvgPicture.asset('assets/svgs/lock-alt.svg'),
                          onPressed: () {},
                        ),
                        onPressed: () {},
                      ),
                      iconS: GestureDetector(
                        child: isShow
                            ? SvgPicture.asset(
                                'assets/svgs/eye.svg',
                                fit: BoxFit.scaleDown,
                              )
                            : SvgPicture.asset(
                                'assets/svgs/eye-slash.svg',
                                fit: BoxFit.scaleDown,
                              ),
                        onTap: () {
                          setState(() {
                            isShow = !isShow;
                          });
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.w,
                        child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: ColorsApp.primary,
                          value: activeBox,
                          onChanged: (bool? bool) {
                            setState(() {
                              activeBox = bool!;
                            });
                          },
                          shape: const CircleBorder(),
                        ),
                      ),
                      const GapW(width: 11),
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'I agree to '.tr(),
                              style: TextStyle(
                                color: const Color(0xFFAAB9C5),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms and conditions'.tr(),
                              style: TextStyle(
                                color: ColorsApp.primary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: ' of the app'.tr(),
                              style: TextStyle(
                                color: const Color(0xFFAAB9C5),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const GapH(height: 29),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 160.w,
                        height: 60.h,
                        child: CustomButtonAcc(
                          color: activeBox ? Colors.transparent : Colors.grey,
                          textColor: activeBox
                              ? const Color.fromARGB(
                                  255,
                                  180,
                                  12,
                                  0,
                                )
                              : Colors.white,
                          text: 'Delete'.tr(),
                          onTap: activeBox
                              ? () {
                                  showModalBottomSheet(
                                    sheetAnimationStyle: const AnimationStyle(
                                      duration: Duration(microseconds: 500000),
                                      curve: Curves.linear,
                                    ),
                                    backgroundColor: Colors.white,
                                    context: context,
                                    builder: (BuildContext context) {
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
                                              SvgPicture.asset(
                                                'assets/svgs/delete-acc.svg',
                                                width: 150.w,
                                                height: 150.h,
                                              ),
                                              const GapH(height: 15),
                                              Text(
                                                'Confirm account deletion'.tr(),
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF2B2F4E),
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const GapH(height: 10),
                                              Text(
                                                textAlign: TextAlign.center,
                                                'When you delete your account, you will permanently lose all your data, including your bookings, courses, and content. This process is irreversible. Make sure you want to delete your account before proceeding.'
                                                    .tr(),
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF637D92),
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              gapH(20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 160.w,
                                                    height: 60.h,
                                                    child: BlocConsumer<
                                                        DeleteDoctorCubit,
                                                        DeleteDoctorState>(
                                                      listener: (context,
                                                          state) async {
                                                        if (state
                                                            is LoadedDeleteDoctorState) {
                                                          await SharedPrefHelper
                                                              .removeData(
                                                                  key: SharedPrefKeys
                                                                      .token);
                                                          await SharedPrefHelper
                                                              .removeData(
                                                                  key: SharedPrefKeys
                                                                      .email);
                                                          await SharedPrefHelper
                                                              .removeData(
                                                                  key: SharedPrefKeys
                                                                      .userId);

                                                          Navigator
                                                              .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const LogInScreen()),
                                                            (route) => false,
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    'Account deleted successfully'
                                                                        .tr())),
                                                          );
                                                        } else if (state
                                                            is FailureDeleteDoctorState) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    'Error: ${state.errorMessage}'
                                                                        .tr())),
                                                          );
                                                        }
                                                      },
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is LoadingDeleteDoctorState) {
                                                          return const Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        }

                                                        return CustomButtonAcc(
                                                          color: Colors.white,
                                                          textColor: const Color
                                                              .fromARGB(
                                                              255, 180, 12, 0),
                                                          text:
                                                              'Confirm deletion'
                                                                  .tr(),
                                                          onTap: () async {
                                                            final userId =
                                                                await SharedPrefHelper.getInt(
                                                                    key: SharedPrefKeys
                                                                        .userId);
                                                            context
                                                                .read<
                                                                    DeleteDoctorCubit>()
                                                                .deleteDoctor(
                                                                    userId);
                                                          },
                                                        );
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
                                    },
                                  );
                                }
                              : null,
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
          ),
        ),
      ),
    );
  }
}
