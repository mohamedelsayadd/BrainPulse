import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Widgets/custom_circle_button_pop.dart';
import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:brain_pulse/core/helpers/spacing.dart';
import 'package:brain_pulse/features/data_by_doctor/logic/cubit/send_data_by_doctor_cubit.dart';
import 'package:brain_pulse/features/data_by_doctor/logic/cubit/send_data_by_doctor_state.dart';
import 'package:brain_pulse/features/data_by_doctor/presentation/screens/display_data.dart';
import 'package:brain_pulse/features/data_by_doctor/presentation/widgets/row_text_with_text_field_get_data_by_doctor.dart';
import 'package:brain_pulse/features/home/presentation/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataByDoctorScreen extends StatelessWidget {
  const DataByDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: BlocListener<SendDataByDoctorCubit, SendDataByDoctorState>(
        listenWhen: (previous, current) {
          return current is FailureSendDataByDoctor ||
              current is LoadingSendDataByDoctor ||
              current is SuccessSendDataByDoctor;
        },
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loadingSendDataByDoctor: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorsApp.primary,
                    ),
                  );
                },
              );
            },
            failureSendDataByDoctor: (message) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: ColorsApp.primary,
                  content: Center(
                    child: Text(
                      'please try again'.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
            successSendDataByDoctor: (data) {
              context.pop();

              context.read<SendDataByDoctorCubit>().p1.clear();
              context.read<SendDataByDoctorCubit>().p2.clear();
              context.read<SendDataByDoctorCubit>().p3.clear();
              context.read<SendDataByDoctorCubit>().p4.clear();
              context.read<SendDataByDoctorCubit>().p5.clear();
              context.read<SendDataByDoctorCubit>().p6.clear();
              context.read<SendDataByDoctorCubit>().p7.clear();
              context.read<SendDataByDoctorCubit>().p8.clear();
              context.read<SendDataByDoctorCubit>().p9.clear();
              context.read<SendDataByDoctorCubit>().p10.clear();
              context.read<SendDataByDoctorCubit>().p11.clear();
              context.read<SendDataByDoctorCubit>().p12.clear();
              context.read<SendDataByDoctorCubit>().p13.clear();
              context.read<SendDataByDoctorCubit>().p14.clear();
              context.read<SendDataByDoctorCubit>().p15.clear();
              context.read<SendDataByDoctorCubit>().p16.clear();
              context.read<SendDataByDoctorCubit>().p17.clear();
              context.read<SendDataByDoctorCubit>().p18.clear();
              context.read<SendDataByDoctorCubit>().p19.clear();
              context.read<SendDataByDoctorCubit>().p20.clear();

              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DisplayData(prediction: data);
                },
              ));
            },
          );
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorsApp.primary,
                        ColorsApp.primary.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: -50.w,
                  top: -50.h,
                  child: Container(
                    width: 200.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsApp.white.withOpacity(0.1),
                    ),
                  ),
                ),
                Positioned(
                  left: -30.w,
                  bottom: -30.h,
                  child: Container(
                    width: 150.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsApp.white.withOpacity(0.1),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => context.pop(),
                              borderRadius: BorderRadius.circular(12.r),
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: ColorsApp.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: ColorsApp.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                          gapW(40),
                          Text(
                            'Enter points'.tr(),
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorsApp.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: ColorsApp.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsApp.grey300.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p1,
                        number: ' 1 '.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p2,
                        number: ' 2 '.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p3,
                        number: ' 3 '.tr(),
                      ),
                      gapH(10),

                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p4,
                        number: ' 4 '.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p5,
                        number: ' 5 '.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p6,
                        number: ' 6 '.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p7,
                        number: ' 7 '.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p8,
                        number: ' 8'.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p9,
                        number: ' 9 '.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p10,
                        number: '10'.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p11,
                        number: '11'.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p12,
                        number: '12'.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p13,
                        number: '13'.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p14,
                        number: '14'.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p15,
                        number: '15'.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p16,
                        number: '16'.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p17,
                        number: '17'.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p18,
                        number: '18'.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p19,
                        number: '19'.tr(),
                      ),
                      gapH(10),
                      RowTextWithTextFieldGetDataByDoctor(
                        controller: context.read<SendDataByDoctorCubit>().p20,
                        number: '20'.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorsApp.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorsApp.grey300.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: CustomButton(
                onTap: () {
                  context.read<SendDataByDoctorCubit>().sendDataByDoctor();
                },
                text: 'Send'.tr(),
                width: double.infinity,
                height: 50.h,
                textColor: ColorsApp.white,
                borderColor: ColorsApp.primary,
                color: ColorsApp.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
