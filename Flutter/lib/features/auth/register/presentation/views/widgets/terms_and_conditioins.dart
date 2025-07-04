import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('By logging. you agree to our '.tr(),
                style: Theme.of(context).textTheme.bodySmall),
            GestureDetector(
              onTap: () {},
              child: Text('Terms & Conditions'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: ColorsApp.grey500)),
            ),
            Text(
              ' and'.tr(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        Center(
            child: GestureDetector(
          onTap: () {},
          child: Text('PrivacyPolicy.'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: ColorsApp.grey500)),
        )),
      ],
    );
  }
}
