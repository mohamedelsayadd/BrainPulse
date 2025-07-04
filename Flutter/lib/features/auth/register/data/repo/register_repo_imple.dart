import 'package:brain_pulse/core/api/auth_api_service.dart';
import 'package:brain_pulse/core/api/failure.dart';
import 'package:brain_pulse/features/auth/register/data/model/register_model.dart';
import 'package:brain_pulse/features/auth/register/data/repo/register_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class RegisterRepoImple implements RegisterRepo {
  AuthApiService authApiService;
  RegisterRepoImple({required this.authApiService});
  @override
  Future<Either<Failure, RegisterModel>> register(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    try {
      var data = await authApiService.post(endpoint: "Auth/Register", data: {
        "Email": email,
        "Password": password,
        "PhoneNumber": phone,
        "Name": name
      });
      return right(RegisterModel.fromJson(data));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioException(e);
      return left(failure);
    }
  }
}

//"email": "engahmedelsherbiny1@gmail.com",
//"password": "P@ssword123",
//"phone": "01012345756",
//"firstName": "Ahmed",
//"lastName": "Sherbiny"