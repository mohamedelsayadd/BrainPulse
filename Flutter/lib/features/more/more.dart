import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:brain_pulse/features/more/ui/screen/my_profile.dart';
import 'package:brain_pulse/features/more/ui/screen/show_my_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/Theming/colors.dart';
import '../../core/helpers/shared_pref_helper/shared_pref_helper.dart';
import '../../core/helpers/spacing.dart';
import '../../core/provider/theme-provider.dart';
import '../home/presentation/screens/widgets/custom_button.dart';

class More extends StatelessWidget {
  const More({super.key});
  static const String routeName = 'More';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 110, right: 10, left: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyProfile(),
              gapH(10.h),
              buildSection(
                title: 'Personal Information'.tr(),
                items: [
                  buildListItem(
                      context, Icons.person, 'My profile'.tr(), '.....'.tr()),
                ],
              ),
              buildSection(
                title: 'Settings'.tr(),
                items: [
                  buildListItem(context, Icons.language, 'Language'.tr(),
                      'Account language settings'.tr()),
                  buildListItem(
                    context,
                    Icons.mode_night_outlined,
                    'Mode'.tr(),
                    themeProvider.isDarkMode
                        ? 'Dark Mode'.tr()
                        : 'Light Mode'.tr(),
                  ),
                ],
              ),
              buildSection(
                title: 'About Us'.tr(),
                items: [
                  buildListItem(context, Icons.mood_rounded, 'About Us'.tr(),
                      '.....'.tr()),
                ],
              ),
              buildSection(
                title: 'Logout'.tr(),
                items: [
                  buildListItem(
                      context, Icons.logout, 'Logout'.tr(), '.....'.tr()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection({required String title, required List<Widget> items}) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          gapH(10.h),
          ...items,
        ],
      ),
    );
  }

  Widget buildListItem(
      BuildContext context, IconData icon, String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ListTile(
        leading: Icon(icon, color: ColorsApp.blue),
        title: Text(title,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios,
            color: Theme.of(context).appBarTheme.iconTheme?.color),
        onTap: () {
          if (title == 'My profile'.tr()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShowMyProfile()),
            );
          } else if (title == 'Language'.tr()) {
            showBottomSheetOptions(
                context, 'Choose Language'.tr(), ['عربي'.tr(), 'English'.tr()]);
          } else if (title == 'Mode'.tr()) {
            showBottomSheetOptions(context, 'Choose Mode'.tr(),
                ['Dark Mode'.tr(), 'Light Mode'.tr()]);
          } else if (title == 'About Us'.tr()) {
            showBottomSheetOptions(context, 'About Us Description'.tr(), []);
          } else if (title == 'Logout'.tr()) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 300.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        gapH(10),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                context.pop();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        gapH(20),
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: ColorsApp.darkRed,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.logout,
                              color: Colors.white,
                              weight: 45.w,
                              size: 40,
                            ),
                          ),
                        ),
                        gapH(10),
                        Text('Logout Now!'.tr(),
                            style: Theme.of(context).textTheme.titleLarge),
                        gapH(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              onTap: () async {
                                await SharedPrefHelper.clearAllData();
                                context.pushReplacementNamed('/loginScreen');
                              },
                              text: 'Logout'.tr(),
                              width: 230,
                              height: 50,
                              color: Colors.white,
                              textColor: ColorsApp.darkRed,
                              borderColor: ColorsApp.darkRed,
                            ),
                            CustomButton(
                              onTap: () {
                                context.pop();
                              },
                              text: 'Cancel'.tr(),
                              width: 100,
                              height: 50,
                              color: Colors.white,
                              textColor: ColorsApp.grey,
                              borderColor: ColorsApp.grey,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void showBottomSheetOptions(
    BuildContext context, String title, List<String> options) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (BuildContext context) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

      return Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.h),
            ...options.map((option) => ListTile(
                  title: Text(option),
                  onTap: () {
                    if (title == 'Choose Mode'.tr()) {
                      if (option == 'Dark Mode'.tr()) {
                        themeProvider.setDarkTheme();
                      } else if (option == 'Light Mode'.tr()) {
                        themeProvider.setLightTheme();
                      }
                    }
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      );
    },
  );
}
