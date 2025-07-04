import 'package:flutter/material.dart';
import '../../../../core/Theming/colors.dart';
import '../../../../core/Widgets/profile_text_field.dart';

class ShowMyProfileWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final String imagePath = 'assets/images/image.jpg';

    return Column(
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
        ProfileTextField(readOnly: true,)
      ],
    )
    ;
  }
}