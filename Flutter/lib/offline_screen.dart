import 'package:brain_pulse/core/Widgets/gap.dart';
import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const OfflineScreen({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorsApp.primary.withOpacity(0.05),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorsApp.primary.withOpacity(0.1),
                            ColorsApp.primary.withOpacity(0.05),
                          ],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorsApp.primary.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.wifi_off_rounded,
                        size: 80,
                        color: ColorsApp.primary,
                      ),
                    ),
                    const GapH(height: 40),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: ColorsApp.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'No Connection',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorsApp.primary,
                            ),
                      ),
                    ),
                    const GapH(height: 24),
                    Text(
                      'You\'re currently offline',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorsApp.primary,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const GapH(height: 16),
                    Text(
                      'Please check your internet connection\nand try again',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorsApp.grey600,
                            height: 1.5,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const GapH(height: 48),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
