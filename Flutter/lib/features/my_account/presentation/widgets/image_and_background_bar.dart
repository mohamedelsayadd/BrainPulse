import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ImageAndBackgroundBar extends StatelessWidget {
  const ImageAndBackgroundBar({
    required this.image,
    required this.background,
    super.key,
  });
  final String image;
  final String background;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 170.h,
              decoration: BoxDecoration(
                color: ColorsApp.primary,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    background,
                  ),
                ),
              ),
            ),
            Container(
              height: 50.h,
            ),
          ],
        ),
        Positioned(
          top: 150.h,
          child: Container(
            width: 376.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26.r),
                topRight: Radius.circular(26.r),
              ),
            ),
          ),
        ),
        Positioned(
          top: 110.h,
          left: 24.w,
          child: CircleAvatar(
            radius: 50.r,
            backgroundColor: Colors.white,
          ),
        ),
        Positioned(
          top: 115.h,
          left: 29.w,
          child: Hero(
            tag: 'edit_image'.tr(),
            child: CircleAvatar(
              radius: 45.r,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(image),
            ),
          ),
        ),
        Positioned(
          top: 115.h,
          left: 29.w,
          child: CircleAvatar(
            radius: 45.r,
            backgroundColor: Colors.transparent.withAlpha(850),
            child: Center(
              child: SvgPicture.asset(
                'assets/svgs/camera.svg',
                color: Colors.white,
                width: 25.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
