import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Widgets/custom_circle_button_pop.dart';
import 'package:brain_pulse/core/helpers/spacing.dart';
import 'package:brain_pulse/features/history/data/model/get_all_patients_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key, required this.patientDetails});
  final Patient patientDetails;

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  gapH(30),
                  _buildPatientInfoCard(),
                  gapH(30),
                  _buildMedicalHistorySection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const CustomCircleButtonPop(),
        gapW(20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.patientDetails.name,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.primary,
                ),
              ),
              gapH(4),
              Text(
                'Patient ID: ${widget.patientDetails.id}'.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        _buildActionButton(
          icon: Icons.message_outlined,
          onTap: () {
            launchUrl(
                Uri.parse('sms:${widget.patientDetails.phoneNumber}'.tr()));
          },
        ),
        gapW(8),
        _buildActionButton(
          icon: Icons.phone_in_talk_outlined,
          onTap: () {
            launchUrl(
                Uri.parse('tel:${widget.patientDetails.phoneNumber}'.tr()));
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(
      {required IconData icon, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsApp.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: ColorsApp.primary),
      ),
    );
  }

  Widget _buildPatientInfoCard() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 90.h,
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                  color: ColorsApp.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/Patient.png',
                    height: 50.h,
                    width: 60.w,
                    fit: BoxFit.scaleDown,
                    color: ColorsApp.primary,
                  ),
                ),
              ),
              gapW(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                        'Phone'.tr(), widget.patientDetails.phoneNumber),
                    gapH(12),
                    _buildInfoRow(
                        'Age'.tr(), '${widget.patientDetails.age} years'.tr()),
                  ],
                ),
              ),
            ],
          ),
          gapH(20),
          const Divider(),
          gapH(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Total Records'.tr(),
                  '${widget.patientDetails.history.records.length}'.tr()),
              _buildStatItem(
                  'Last Update'.tr(),
                  widget.patientDetails.history.records.isNotEmpty
                      ? widget.patientDetails.history.records.first.dateRecorded
                          .toString()
                          .substring(0, 10)
                      : 'N/A'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorsApp.primary,
          ),
        ),
        gapH(4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMedicalHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Medical History'.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorsApp.primary,
              ),
            ),
          ],
        ),
        gapH(20),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.patientDetails.history.records.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final record = widget.patientDetails.history.records[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: _buildHistoryCard(record, index),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHistoryCard(MedicalRecord record, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: ColorsApp.primary.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 16.sp, color: ColorsApp.primary),
                    gapW(8),
                    Text(
                      record.dateRecorded.toString().substring(0, 10),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorsApp.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ColorsApp.primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'Record #${index + 1}'.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                _buildMetricRow('GPD'.tr(),
                    '${(record.gpd * 100).toStringAsFixed(1)}%'.tr()),
                gapH(12),
                _buildMetricRow('GRDA'.tr(),
                    '${(record.grda * 100).toStringAsFixed(1)}%'.tr()),
                gapH(12),
                _buildMetricRow('LPD'.tr(),
                    '${(record.ipd * 100).toStringAsFixed(1)}%'.tr()),
                gapH(12),
                _buildMetricRow('LRDA'.tr(),
                    '${(record.irda * 100).toStringAsFixed(1)}%'.tr()),
                gapH(12),
                _buildMetricRow('Seizure'.tr(),
                    '${(record.seizure * 100).toStringAsFixed(1)}%'.tr()),
                gapH(12),
                _buildMetricRow('Other'.tr(),
                    '${(record.other * 100).toStringAsFixed(1)}%'.tr()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: '.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: ColorsApp.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: ColorsApp.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorsApp.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
