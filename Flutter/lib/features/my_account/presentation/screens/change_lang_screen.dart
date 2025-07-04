import 'package:brain_pulse/core/Widgets/gap.dart';
import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangeLangScreen extends StatefulWidget {
  const ChangeLangScreen({super.key});

  @override
  State<ChangeLangScreen> createState() => _ChangeLangScreenState();
}

class _ChangeLangScreenState extends State<ChangeLangScreen> {
  String? _selectedLang;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: AppBar(
        title: Text(
          'change_lang'.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: ColorsApp.grey900,
          ),
        ),
        backgroundColor: ColorsApp.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorsApp.grey900,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'select_lang'.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorsApp.grey600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GapH(height: 16.h),
              Expanded(
                child: ListView(
                  children: [
                    _buildLanguageCard(
                      'en',
                      'English',
                      Icons.language,
                      ColorsApp.primary,
                      'https://flagcdn.com/24x18/gb.png',
                    ),
                    GapH(height: 12.h),
                    _buildLanguageCard(
                      'ar',
                      'Arabic',
                      Icons.language,
                      ColorsApp.primary,
                      'https://flagcdn.com/24x18/sa.png',
                    ),
                  ],
                ),
              ),
              GapH(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedLang != null) {
                      sharedPreferences.setString('lang', _selectedLang!);
                      context.setLocale(Locale(_selectedLang!));
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    'save'.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsApp.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard(
    String code,
    String name,
    IconData icon,
    Color color,
    String flagUrl,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLang = code;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: ColorsApp.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.grey400.withOpacity(0.1),
              blurRadius: 16.r,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: _selectedLang == code ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                flagUrl,
                width: 24.w,
                height: 24.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: ColorsApp.grey300,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.language,
                    color: ColorsApp.grey600,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
            GapW(width: 12.w),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: _selectedLang == code ? color : ColorsApp.grey900,
                ),
              ),
            ),
            if (_selectedLang == code)
              Icon(
                Icons.check_circle,
                color: color,
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }
}
