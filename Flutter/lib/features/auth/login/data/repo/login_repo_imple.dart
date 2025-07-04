import 'package:brain_pulse/core/api/auth_api_service.dart';
import 'package:brain_pulse/core/api/failure.dart';
import 'package:brain_pulse/features/auth/login/data/model/login_model.dart';
import 'package:brain_pulse/features/auth/login/data/repo/login_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class LoginRepoImple implements LoginRepo {
  final AuthApiService authApiService;
  LoginRepoImple({required this.authApiService});
  @override
  Future<Either<Failure, LoginModel>> postlogin(
      {required String email, required String password}) async {
    try {
      var data = await authApiService.post(
          endpoint: "Auth/login", data: {"Email": email, "Password": password});
      return right(LoginModel.fromJson(data));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioException(e);
      return left(failure);
    }
  }
}
