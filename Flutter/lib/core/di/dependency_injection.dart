import 'package:brain_pulse/core/api/auth_api_service.dart';
import 'package:brain_pulse/core/network/api_service.dart';
import 'package:brain_pulse/core/network/dio_factory.dart';
import 'package:brain_pulse/features/auth/login/data/repo/login_repo_imple.dart';
import 'package:brain_pulse/features/auth/register/data/repo/register_repo_imple.dart';
import 'package:brain_pulse/features/data_by_doctor/data/repo/doctor_repo.dart';
import 'package:brain_pulse/features/data_by_doctor/logic/cubit/send_data_by_doctor_cubit.dart';
import 'package:brain_pulse/features/history/data/repo/get_all_patients_repo.dart';
import 'package:brain_pulse/features/history/logic/cubit/get_all_patients_cubit.dart';
import 'package:brain_pulse/features/home/data/repo/predict_file_repo_imple.dart';
import 'package:brain_pulse/features/home/presentation/controller/cubit/prediction_file_cubit.dart';
import 'package:brain_pulse/features/privacy_and_security/data/repo/privacy_repo_imple.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  Dio dio = DioFactory2.getDio();

  // API Services
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  getIt.registerLazySingleton<AuthApiService>(() => AuthApiService());

  // login
  getIt.registerLazySingleton<LoginRepoImple>(
      () => LoginRepoImple(authApiService: getIt<AuthApiService>()));
  //register
  getIt.registerLazySingleton<RegisterRepoImple>(
      () => RegisterRepoImple(authApiService: getIt<AuthApiService>()));
  //changepass
  getIt.registerLazySingleton<PrivacyRepoImple>(
      () => PrivacyRepoImple(authApiService: getIt<AuthApiService>()));
//predict image
  getIt.registerSingleton<PredictFileRepoImple>(
    PredictFileRepoImple(authApiService: getIt<AuthApiService>()),
  );
  getIt.registerFactory<PredictionFileCubit>(
    () => PredictionFileCubit(
        predictFileRepoImple: getIt<PredictFileRepoImple>()),
  );

  // send data by doctor
  getIt.registerLazySingleton<SendDataByDoctorCubit>(
      () => SendDataByDoctorCubit(getIt(), AddPatientRepo(ApiService(dio))));

  getIt.registerFactory<SendPointRepo>(() => SendPointRepo(getIt()));

  // get All Patients
  getIt.registerLazySingleton<GetAllPatientsCubit>(
      () => GetAllPatientsCubit(getIt()));

  getIt.registerFactory<GetAllPatientsRepo>(() => GetAllPatientsRepo(getIt()));

  // Add Patient
  getIt.registerFactory<AddPatientRepo>(() => AddPatientRepo(getIt()));
}
