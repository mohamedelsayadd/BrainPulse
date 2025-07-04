import 'package:brain_pulse/features/app_navigation/app_navigation.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Widgets/gap.dart';
import 'package:brain_pulse/core/Widgets/mytextfield.dart';
import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:brain_pulse/core/helpers/spacing.dart';
import 'package:brain_pulse/features/data_by_doctor/data/models/add_patient_request_model.dart';
import 'package:brain_pulse/features/data_by_doctor/logic/cubit/send_data_by_doctor_cubit.dart';
import 'package:brain_pulse/features/data_by_doctor/logic/cubit/send_data_by_doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveAndCreatePatient extends StatelessWidget {
  const SaveAndCreatePatient({super.key, required this.prediction});
  final Map<String, dynamic> prediction;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    double parsePrediction(dynamic value) {
      if (value == null) return 0.0;

      String strValue = value.toString().replaceAll('%', '').trim();
      final parsed = double.tryParse(strValue);
      return (parsed ?? 0.0) / 100;
    }

    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: AppBar(
        backgroundColor: ColorsApp.primary,
        title: Text(
          'Add patient'.tr(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 22,
                color: ColorsApp.white,
              ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<SendDataByDoctorCubit, SendDataByDoctorState>(
        listenWhen: (previous, current) {
          return current is FailureAddPatient ||
              current is LoadingAddPatient ||
              current is SuccessAddPatient;
        },
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loadingAddPatient: () {
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
            failureAddPatient: (message) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                    child: Text(
                      'please try again'.tr(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            successAddPatient: (data) {
              // context.pop();
              // Navigator.pop(context);
              // Navigator.pop(context);
              // Navigator.pop(context, true);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AppNavigation()),
                (route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                    child: Text(
                      'add success'.tr(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          );
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GapH(height: 20),
                  Text(
                    'Name :'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorsApp.black,
                        ),
                  ),
                  gapH(8),
                  SizedBox(
                    child: MyTextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      hint: 'Enter patient name'.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter patient name'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  gapH(20),
                  Text(
                    'Phone :'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorsApp.black,
                        ),
                  ),
                  gapH(8),
                  SizedBox(
                    child: MyTextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      hint: 'Enter phone number'.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  gapH(20),
                  Text(
                    'Age :'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorsApp.black,
                        ),
                  ),
                  gapH(8),
                  SizedBox(
                    child: MyTextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      hint: 'Enter age'.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter age'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  gapH(20),
                  Text(
                    'Description :'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorsApp.black,
                        ),
                  ),
                  gapH(8),
                  TextField(
                    controller: descriptionController,
                    maxLines: 5,
                    minLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Enter patient description'.tr(),
                      hintStyle: TextStyle(color: ColorsApp.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                          color: ColorsApp.grey300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                          color: ColorsApp.primary,
                        ),
                      ),
                    ),
                  ),
                  gapH(20),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.h,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 60.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorsApp.primary,
                            ColorsApp.primary.withOpacity(0.8),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: ColorsApp.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              if (prediction.keys.toSet().containsAll([
                                'GPD',
                                'GRDA',
                                'LPD',
                                'LRDA',
                                'Seizure',
                                'Other',
                              ])) {
                                context
                                    .read<SendDataByDoctorCubit>()
                                    .addPatient(
                                      AddPatientRequestModel(
                                        age: int.parse(ageController.text),
                                        name: nameController.text,
                                        phoneNumber: phoneController.text,
                                        gpd: parsePrediction(prediction['GPD']),
                                        grda:
                                            parsePrediction(prediction['GRDA']),
                                        ipd: parsePrediction(prediction['LPD']),
                                        irda:
                                            parsePrediction(prediction['LRDA']),
                                        seizure: parsePrediction(
                                            prediction['Seizure']),
                                        other: parsePrediction(
                                            prediction['Other']),
                                        Notes: '',
                                      ),
                                    );
                              } else if (prediction.length == 1 &&
                                  prediction.containsKey("Other")) {
                                context
                                    .read<SendDataByDoctorCubit>()
                                    .addPatient(
                                      AddPatientRequestModel(
                                        age: int.parse(ageController.text),
                                        name: nameController.text,
                                        phoneNumber: phoneController.text,
                                        gpd: 0.0,
                                        grda: 0.0,
                                        ipd: 0.0,
                                        irda: 0.0,
                                        seizure: 0.0,
                                        other: 1.0,
                                        Notes: '',
                                      ),
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("❌ بيانات التحليل غير مكتملة"),
                                  ),
                                );
                              }
                            }
                          },

                          // if (formKey.currentState!.validate()) {
                          //   context.read<SendDataByDoctorCubit>().addPatient(
                          //         AddPatientRequestModel(
                          //           age: int.parse(ageController.text),
                          //           name: nameController.text,
                          //           phoneNumber: phoneController.text,
                          //           gpd: prediction[0].toDouble(),

                          //           grda: prediction[1].toDouble(),
                          //           ipd: prediction[2].toDouble(),
                          //           irda: prediction[3].toDouble(),
                          //           seizure: prediction[4].toDouble(),
                          //           other: prediction[5].toDouble(),
                          //         ),
                          //       );
                          // }
                          borderRadius: BorderRadius.circular(16.r),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Save'.tr(),
                                  style: TextStyle(
                                    color: ColorsApp.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
