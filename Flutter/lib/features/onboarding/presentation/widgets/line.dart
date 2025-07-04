import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class line extends StatelessWidget {
  const line({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey.withOpacity(0.5),
      indent: 15.w,
      endIndent: 15.w,
    );
  }
}

