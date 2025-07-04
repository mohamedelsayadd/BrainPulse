import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';

class BinarySignalData extends StatefulWidget {
  const BinarySignalData({super.key});

  @override
  State<BinarySignalData> createState() => _BinarySignalDataState();
}

class _BinarySignalDataState extends State<BinarySignalData>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> brainSignalData = [
    {
      'title': 'Seizure',
      'icon': Icons.flash_on,
      'description':
          'Sudden bursts of rapid, repetitive electrical activity.'.tr(),
      'Possible diseases': 'Epilepsy, brain injury, infections, tumors.'.tr(),
      'Treatment': 'Anti-seizure medications, surgery, lifestyle changes.'.tr(),
    },
    {
      'title': 'LPD',
      'icon': Icons.waves,
      'description':
          'Repeating spikes from one side of the brain at regular intervals.'
              .tr(),
      'Possible diseases': 'Stroke, brain infections, tumors, epilepsy.'.tr(),
      'Treatment':
          'Treat underlying cause (infection/stroke), anti-seizure meds if needed.'
              .tr(),
    },
    {
      'title': 'GPD',
      'icon': Icons.sync_alt,
      'description':
          'Repeating spikes from both sides of the brain simultaneously.'.tr(),
      'Possible diseases':
          'Brain damage, coma, severe metabolic issues, encephalopathy.'.tr(),
      'Treatment':
          'Supportive care, treat root causes (toxins, infections).'.tr(),
    },
    {
      'title': 'LRDA',
      'icon': Icons.trending_flat,
      'description': 'Slow, rhythmic waves from one side of the brain.'.tr(),
      'Possible diseases': 'Stroke, tumors, trauma, seizures.'.tr(),
      'Treatment':
          'Focus on underlying brain problem; seizure meds may be used.'.tr(),
    },
    {
      'title': 'GRDA',
      'icon': Icons.blur_on,
      'description': 'Slow rhythmic waves from both sides of the brain.'.tr(),
      'Possible diseases':
          'Encephalopathy, coma, deep sleep state, brain dysfunction.'.tr(),
      'Treatment':
          'Treat underlying condition (infection/metabolic issue), supportive care.'
              .tr(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSelect(int index) {
    if (selectedIndex != index) {
      _controller.reverse().then((_) {
        setState(() {
          selectedIndex = index;
        });
        _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selector
        SizedBox(
          height: 50.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: brainSignalData.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => _onSelect(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorsApp.primary.withOpacity(0.15)
                        : theme.cardColor,
                    borderRadius: BorderRadius.circular(18.r),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: ColorsApp.primary.withOpacity(0.18),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                    border: Border.all(
                      color: isSelected
                          ? ColorsApp.primary
                          : Colors.grey.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        brainSignalData[index]['icon'],
                        color: isSelected
                            ? ColorsApp.primary
                            : ColorsApp.primary.withOpacity(0.5),
                        size: 24,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        brainSignalData[index]['title'],
                        style: TextStyle(
                          color: isSelected
                              ? ColorsApp.primary
                              : ColorsApp.primary.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 18.h),
        // Animated content
        FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _InfoCard(
                title: 'Description'.tr(),
                icon: Icons.info_outline,
                content: brainSignalData[selectedIndex]['description'],
                color: ColorsApp.primary,
              ),
              SizedBox(height: 12.h),
              _InfoCard(
                title: 'Possible diseases'.tr(),
                icon: Icons.local_hospital_outlined,
                content: brainSignalData[selectedIndex]['Possible diseases'],
                color: Colors.redAccent,
              ),
              SizedBox(height: 12.h),
              _InfoCard(
                title: 'Treatment'.tr(),
                icon: Icons.healing_outlined,
                content: brainSignalData[selectedIndex]['Treatment'],
                color: Colors.green,
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;
  final Color color;
  @override
  final Key? key;

  const _InfoCard({
    this.key,
    required this.title,
    required this.icon,
    required this.content,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.r),
      ),
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.10), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.10),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: color.withOpacity(0.18),
            width: 1.2,
          ),
        ),
        padding: EdgeInsets.all(18.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.18),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.10),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(10.w),
              child: Icon(icon, color: color, size: 34),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 15.5.sp,
                      color: ColorsApp.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
