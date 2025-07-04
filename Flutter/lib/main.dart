import 'package:brain_pulse/brain_pulse.dart';
import 'package:brain_pulse/core/di/dependency_injection.dart';
import 'package:brain_pulse/core/helpers/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'core/provider/language.provider.dart';
import 'core/provider/theme-provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

late SharedPreferences sharedPreferences;
late bool isLoggedIn;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupGetIt();
  Bloc.observer = MyBlocObserver();

  sharedPreferences = await SharedPreferences.getInstance();
  isLoggedIn = sharedPreferences.getString('token') != null;
  await SentryFlutter.init((options) {
    options.dsn =
        'https://35580dd33785214ad47229124fb787db@o4509560728059904.ingest.us.sentry.io/4509560732516352';
    options.tracesSampleRate = 0.01;
  },
      appRunner: () => runApp(
            MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => ThemeProvider()),
                ChangeNotifierProvider(create: (_) => LocaleProvider()),
              ],
              child: EasyLocalization(
                  supportedLocales: const [Locale('en'), Locale('ar')],
                  path: 'assets/lang',
                  saveLocale: true,
                  fallbackLocale: const Locale('en'),
                  child: const BrainPulse()),
            ),
          ));
}


// email : baz@gmail.com
// pass : 00