import 'package:brain_pulse/core/di/dependency_injection.dart';
import 'package:brain_pulse/core/routing/routers.dart';
import 'package:brain_pulse/core/routing/app_router.dart';
import 'package:brain_pulse/features/auth/login/data/repo/login_repo_imple.dart';
import 'package:brain_pulse/features/auth/login/presentation/controller/cubit/login_cubit.dart';
import 'package:brain_pulse/features/auth/register/data/repo/register_repo_imple.dart';
import 'package:brain_pulse/features/auth/register/presentation/controller/cubit/register_cubit.dart';
import 'package:brain_pulse/features/data_by_doctor/logic/cubit/send_data_by_doctor_cubit.dart';
import 'package:brain_pulse/features/history/logic/cubit/get_all_patients_cubit.dart';
import 'package:brain_pulse/features/home/presentation/controller/cubit/prediction_file_cubit.dart';
import 'package:brain_pulse/features/privacy_and_security/data/repo/privacy_repo_imple.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/controller/cubit/changepass/change_pass_cubit.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/controller/cubit/deletedoctor/delete_doctor_cubit.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/controller/cubit/editdoctor/edit_doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/provider/language.provider.dart';
import 'core/provider/theme-provider.dart';
import 'package:easy_localization/easy_localization.dart';

class BrainPulse extends StatelessWidget {
  const BrainPulse({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<SendDataByDoctorCubit>(),
          ),
          BlocProvider(
            create: (context) => ChangePassCubit(
                privacyRepoImple: getIt.get<PrivacyRepoImple>()),
          ),
          BlocProvider(
            create: (context) => EditDoctorCubit(
                privacyRepoImple: getIt.get<PrivacyRepoImple>()),
          ),
          BlocProvider(
            create: (context) => DeleteDoctorCubit(
                privacyRepoImple: getIt.get<PrivacyRepoImple>()),
          ),
          BlocProvider(
            create: (context) => getIt<GetAllPatientsCubit>(),
          ),
          BlocProvider(
            create: (context) =>
                LoginCubit(loginRepoImple: getIt.get<LoginRepoImple>()),
          ),
          BlocProvider(
            create: (context) => RegisterCubit(
                registerRepoImple: getIt.get<RegisterRepoImple>()),
          ),
          BlocProvider(
            create: (context) => getIt<PredictionFileCubit>(),
          ),
        ],
        child: Consumer2<ThemeProvider, LocaleProvider>(
          builder: (context, themeProvider, localeProvider, child) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'Brain Pulse',
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splashScreen,
              onGenerateRoute: AppRouter.generateRoute,
              theme: themeProvider.currentTheme,
              // locale: localeProvider.currentLocale,
            );
          },
        ),
      ),
    );
  }
}
