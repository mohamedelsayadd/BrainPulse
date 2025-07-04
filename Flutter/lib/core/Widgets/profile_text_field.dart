import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theming/colors.dart';
import '../helpers/spacing.dart';

class ProfileTextField extends StatelessWidget {
  final bool readOnly;
  const ProfileTextField({
    super.key,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH(20.h),
        TextField(
          readOnly: readOnly,
          //controller:_PassAndEmailState.name,
          decoration: InputDecoration(
            hintText: 'name',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorsApp.grey500, width: 2.0),
            ),
          ),
        ),
        gapH(20.h),
        TextField(
          readOnly: readOnly,
          //controller:PassAndEmail.email,
          decoration: InputDecoration(
            hintText: 'email',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorsApp.grey500, width: 2.0),
            ),
          ),
        ),
        //gapH(20.h),
        // TextField(
        //   readOnly: readOnly,
        //   // controller:PassAndEmail.password,
        //   decoration: InputDecoration(
        //     hintText: 'password',
        //     border: UnderlineInputBorder(
        //       borderSide: BorderSide(color: ColorsApp.grey500, width: 2.0),
        //     ),
        //   ),
        // ),
        gapH(20.h),
        TextField(
          readOnly: readOnly,
          //controller:PassAndEmail.phone,
          decoration: InputDecoration(
            hintText: 'phone number',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorsApp.grey500, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}
