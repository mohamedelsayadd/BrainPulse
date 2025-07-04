import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Widgets/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/Widgets/custom_circle_button_pop.dart';
import '../../../../core/Widgets/profile_photo_widget.dart';
import '../../../../core/helpers/spacing.dart';
import '../widget/edit_my_profile_widget.dart';

class EditMyProfile extends StatelessWidget {
  const EditMyProfile({super.key});
  static const String routeName = 'EditProfile';

  @override
  Widget build(BuildContext context) {
    final String? imagePath =
        ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Edit Profile'.tr(),
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading: const CustomCircleButtonPop()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 100, right: 15, left: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfilePhotoWidget(
                imagePath: imagePath,
              ),
              EditMyProfileWidget(),
              gapH(20.h),
              TextField(
                // controller:PassAndEmail.password,
                decoration: InputDecoration(
                  hintText: 'password'.tr(),
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsApp.grey500, width: 2.0),
                  ),
                ),
              ),
              gapH(190.h),
              MyButton(text: 'Save Changes'.tr(), onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
