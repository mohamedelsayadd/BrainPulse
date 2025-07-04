import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Widgets/custom_circle_button_pop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/provider/language.provider.dart';
import '../../../../generated/app_localizations.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Row(
              children: [
                SizedBox(width: 15.w),
                const CustomCircleButtonPop(),
                SizedBox(width: 70.w),
                Text(
                    AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  title: Text("English"),
                  trailing: Radio<String>(
                    value: 'en',
                    groupValue: localeProvider.currentLocale.languageCode,
                    onChanged: (value) {
                      if (value != null) {
                        localeProvider.setLocale(value);
                      }
                    },
                    activeColor: ColorsApp.primary,
                  ),
                ),
                ListTile(
                  title: Text("العربية"),
                  trailing: Radio<String>(
                    value: 'ar',
                    groupValue: localeProvider.currentLocale.languageCode,
                    onChanged: (value) {
                      if (value != null) {
                        localeProvider.setLocale(value);
                      }
                    },
                    activeColor: ColorsApp.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
