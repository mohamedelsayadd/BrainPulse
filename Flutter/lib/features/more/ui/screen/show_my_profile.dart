import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import '../../../../core/Theming/colors.dart';
import '../../../../core/Widgets/custom_circle_button_pop.dart';
import '../widget/show_my_profile_widget.dart';
import 'edit_profile.dart';

class ShowMyProfile extends StatelessWidget {
  const ShowMyProfile({super.key});
  final String imagePath = 'assets/images/image.jpg';
  static const String routeName = 'ShowMyProfile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my Profile'.tr(),
            style: Theme.of(context).appBarTheme.titleTextStyle),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: const CustomCircleButtonPop(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
            tooltip: 'Open Edit Screen'.tr(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditMyProfile(),
                  settings: RouteSettings(arguments: imagePath),
                ),
              );
            },
          ),
          // ...rest of body...
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 100, right: 15, left: 15),
        child: Column(
          children: [ShowMyProfileWidget()],
        ),
      ),
    );
  }
}
