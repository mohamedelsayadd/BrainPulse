import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:brain_pulse/features/data_by_doctor/presentation/screens/save_and_create_patient.dart';
import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisplayData extends StatelessWidget {
  const DisplayData({super.key, required this.prediction});
  final Map<String, dynamic> prediction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: AppBar(
        backgroundColor: ColorsApp.primary,
        title: Text(
          'Analysis Results'.tr(),
          style: TextStyle(color: ColorsApp.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorsApp.primary.withOpacity(0.1),
              ColorsApp.white,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: ColorsApp.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsApp.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Patient Analysis Results'.tr(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: ColorsApp.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 20.h),
                      // _buildResultRow(
                      //     context, 'GPD'.tr(), prediction[0].toString()),
                      // _buildResultRow(
                      //     context, 'GRDA'.tr(), prediction[1].toString()),
                      // _buildResultRow(
                      //     context, 'LPD'.tr(), prediction[2].toString()),
                      // _buildResultRow(
                      //     context, 'LRDA'.tr(), prediction[3].toString()),
                      // _buildResultRow(
                      //     context, 'Seizure'.tr(), prediction[4].toString()),
                      // _buildResultRow(
                      //     context, 'Other'.tr(), prediction[5].toString()),
                      ...prediction.entries.map((entry) {
                        return _buildResultRow(
                          context,
                          entry.key.tr(),
                          entry.value.toString(),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorsApp.primary,
                        ColorsApp.primary.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
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
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SaveAndCreatePatient(
                              prediction: prediction,
                            );
                          },
                        ));
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Center(
                        child: Text(
                          'Save and Add Patient'.tr(),
                          style: TextStyle(
                            color: ColorsApp.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: ColorsApp.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: ColorsApp.primary,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsApp.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.pop();
                        context.pop();
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Center(
                        child: Text(
                          'Cancel'.tr(),
                          style: TextStyle(
                            color: ColorsApp.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildResultRow(BuildContext context, String label, String value) {
    // Convert the value to a percentage
    // double percentageValue = double.parse(value) * 100;
    // String formattedValue = '${percentageValue.toStringAsFixed(2)}%'.tr();
    String cleanedValue = value.replaceAll('%', '').trim();

    double? parsedValue = double.tryParse(cleanedValue);
    String formattedValue =
        parsedValue != null ? '${parsedValue.toStringAsFixed(2)}%' : value;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ColorsApp.secondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorsApp.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              formattedValue,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsApp.primary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
