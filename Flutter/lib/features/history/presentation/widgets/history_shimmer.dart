import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/features/history/presentation/widgets/user_card_info.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HistoryShimmer extends StatelessWidget {
  const HistoryShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: const UserCardInfo(
              name: '...',
              phone: '...',
            ),
          );
        },
      ),
    );
  }
}
