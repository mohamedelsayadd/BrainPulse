import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ionicons/ionicons.dart';

class UserCardInfo extends StatelessWidget {
  const UserCardInfo({
    super.key,
    required this.name,
    required this.phone,
  });
  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: ColorsApp.grey500.withOpacity(0.05),
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(phone),
        leading: Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(555.r),
            color: ColorsApp.primary.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1), // Shadow color
                spreadRadius: 2, // How much the shadow spreads
                blurRadius: 5, // How blurry the shadow is
                offset: const Offset(0, 3), // Offset of the shadow (x, y)
              ),
            ],
          ),
          child: Icon(
            Ionicons.person_outline,
            color: ColorsApp.primary,
          ),
        ),
      ),
    );
  }
}
