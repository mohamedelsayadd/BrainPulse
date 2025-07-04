import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CardItemInMyAccount extends StatelessWidget {
  CardItemInMyAccount(
      {required this.icon,
      required this.title,
      required this.subTitle,
      this.colorBackgroundIcon,
      this.onTap,
      this.titleColor,
      super.key,
      this.isLogout,
      this.height,
      this.colorsvg,
      this.width});

  final String icon;
  final Color? colorBackgroundIcon;
  final String title;
  final Color? titleColor;
  final String subTitle;
  final Color? colorsvg;
  final void Function()? onTap;
  final bool? isLogout;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Container(
              width: 48.w,
              height: 48.h,
              decoration: ShapeDecoration(
                color: colorBackgroundIcon ??
                    Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48.r),
                ),
              ),
              child: SvgPicture.asset(
                icon,
                fit: BoxFit.scaleDown,
                width: width,
                height: height,
                color: colorsvg,
              ),
            ),
            const GapW(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor ??
                        (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : const Color(0xFF1D2035)),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const GapH(height: 4),
                SizedBox(
                  width: 230.w,
                  child: Text(
                    subTitle,
                    style: TextStyle(
                      color: const Color(0xFF9DA1A6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (isLogout == true)
              const SizedBox.shrink()
            else
              Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.keyboard_arrow_left_rounded
                    : Icons.keyboard_arrow_right_rounded,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}

class CardItemInMyAccountImage extends StatelessWidget {
  const CardItemInMyAccountImage({
    required this.icon,
    required this.title,
    required this.subTitle,
    this.colorBackgroundIcon,
    this.onTap,
    this.titleColor,
    super.key,
    this.isLogout,
  });

  final String icon;
  final Color? colorBackgroundIcon;
  final String title;
  final Color? titleColor;
  final String subTitle;
  final void Function()? onTap;
  final bool? isLogout;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Container(
              width: 48.w,
              height: 48.h,
              decoration: ShapeDecoration(
                color: colorBackgroundIcon ??
                    Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48.r),
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: Image.asset(
                    icon,
                    fit: BoxFit.scaleDown,
                    color: ColorsApp.primary,
                  ),
                ),
              ),
            ),
            const GapW(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor ??
                        (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : const Color(0xFF1D2035)),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const GapH(height: 4),
                SizedBox(
                  width: 230.w,
                  child: Text(
                    subTitle,
                    style: TextStyle(
                      color: const Color(0xFF9DA1A6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (isLogout == true)
              const SizedBox.shrink()
            else
              Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.keyboard_arrow_left_rounded
                    : Icons.keyboard_arrow_right_rounded,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}
