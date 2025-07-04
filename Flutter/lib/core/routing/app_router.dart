import 'package:brain_pulse/core/routing/animation_route.dart';
import 'package:brain_pulse/core/routing/routers.dart';
import 'package:brain_pulse/features/app_navigation/app_navigation.dart';
import 'package:brain_pulse/features/auth/login/presentation/views/login.dart';
import 'package:brain_pulse/features/data_by_doctor/presentation/screens/display_data.dart';
import 'package:brain_pulse/features/home/presentation/screens/eeg_data_screen.dart';
import 'package:brain_pulse/features/data_by_doctor/presentation/screens/data_by_doctor_screen.dart';
import 'package:brain_pulse/features/home/presentation/screens/prediction_file_screen.dart';
import 'package:brain_pulse/features/home/presentation/screens/home_screen.dart';
import 'package:brain_pulse/features/my_account/presentation/screens/edit_profile_screen.dart';
import 'package:brain_pulse/features/my_account/presentation/screens/theme_mode_screen.dart';
import 'package:brain_pulse/features/onboarding/presentation/screens/onboarding.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/screens/change_password_screen.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/screens/delete_account.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/screens/privacy_and_security.dart';
import 'package:brain_pulse/features/splash/presentation/views/spalsh_screen.dart';
import 'package:brain_pulse/offline_screen.dart';
import 'package:flutter/material.dart';

import '../../features/my_account/presentation/screens/change_language_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    var arg = settings.arguments;
    switch (settings.name) {
      case Routes.offline:
        return AppHelperFunctions().fadeTransition(
          page: OfflineScreen(
            onRetry: () {},
          ),
        );
      case Routes.splashScreen:
        return AppHelperFunctions().fadeTransition(
          page: const SplashScreen(),
        );
      case Routes.onBoarding:
        return AppHelperFunctions().fadeTransition(
          page: const Onboarding(),
        );
      case Routes.loginScreen:
        return AppHelperFunctions().fadeTransition(
          page: const LogInScreen(),
        );
      case Routes.appNavigation:
        return AppHelperFunctions().fadeTransition(
          page: const AppNavigation(),
        );
      case Routes.homeScreen:
        return AppHelperFunctions().fadeTransition(
          page: const HomeScreen(),
        );
      case Routes.getImage:
        return AppHelperFunctions().slideFromRightTransition(
          page: const GetImageScreen(),
        );
      case Routes.eegdata:
        return AppHelperFunctions().fadeTransition(
          page: const EegDataScreen(),
        );
      case Routes.displayData:
        return AppHelperFunctions().fadeTransition(
          page: DisplayData(
            prediction: arg as Map<String, dynamic>,
          ),
        );
      case Routes.dataByDoctorScreen:
        return AppHelperFunctions().slideFromRightTransition(
          page: const DataByDoctorScreen(),
        );
      case Routes.editProfileScreen:
        return AppHelperFunctions().fadeTransition(
          page: const EditProfileScreen(),
        );
      case Routes.privacyAndSecurity:
        return AppHelperFunctions().fadeTransition(
          page: const PrivacyAndSecurity(),
        );
      case Routes.changePasswordScreen:
        return AppHelperFunctions().fadeTransition(
          page: const ChangePasswordScreen(),
        );
      case Routes.deleteAccount:
        return AppHelperFunctions().fadeTransition(
          page: const DeleteAccount(),
        );
      case Routes.thememode:
        return AppHelperFunctions().fadeTransition(
          page: const ThemeModeScreen(),
        );
      case Routes.languageScreen:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("NO route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
