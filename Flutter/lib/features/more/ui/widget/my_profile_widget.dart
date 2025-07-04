import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/Theming/colors.dart';
import '../../../../core/Theming/text_style.dart';
import '../../../../core/helpers/spacing.dart';

class MyProfileWidget extends StatelessWidget {
  String? text1;
  String? text2;
  final String imagePath = 'assets/images/image.jpg';

  MyProfileWidget([this.text1, this.text2]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: ColorsApp.grey500,
              backgroundImage:
                  imagePath != null ? AssetImage(imagePath!) : null,
              child: imagePath == null
                  ? Icon(Icons.person, size: 55, color: ColorsApp.white)
                  : null,
            ),
            gapH(5.h),
            Text(
              'my profile'.tr(),
              style: TextStyleApp.font14weight400colorGrey
                  .copyWith(color: ColorsApp.blue, fontSize: 25),
            ),
          ],
        ),
      ],
    );
  }
}
