import 'package:brain_pulse/features/more/ui/widget/my_profile_widget.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {

    return
        Column(
          children: [
            MyProfileWidget()
        ]
    );
  }
}
