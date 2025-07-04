import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/features/auth/login/presentation/views/ui/widgets/Sinup.dart';
import 'package:brain_pulse/features/auth/register/presentation/views/widgets/terms_and_conditioins.dart';
import 'package:flutter/material.dart';

class Lowerdesignlogin extends StatefulWidget {
  const Lowerdesignlogin({super.key});

  @override
  State<Lowerdesignlogin> createState() => _lowerDesignLoginState();
}

class _lowerDesignLoginState extends State<Lowerdesignlogin> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        // const Row(
        //   children: [
        //     Expanded(
        //       child: Divider(
        //         color: Color(0xffe0e0e0),
        //         thickness: 1,
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 8.0),
        //       child: Text(
        //         'Or sign in with'.tr(),
        //         style: TextStyle(color: Colors.black54),
        //       ),
        //     ),
        //     Expanded(
        //       child: Divider(
        //         color: Color(0xffe0e0e0),
        //         thickness: 1,
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: screenSize.height * .04,
        // ),
        // const SignInWith(),
        // SizedBox(
        //   height: screenSize.height * .04,
        // ),
        const TermsAndConditions(),
        SizedBox(
          height: screenSize.height * .04,
        ),
        SignUp(
          text3: 'Don\'t Have any Account? '.tr(),
          text4: 'Create Account'.tr(),
        ),
      ],
    );
  }
}
