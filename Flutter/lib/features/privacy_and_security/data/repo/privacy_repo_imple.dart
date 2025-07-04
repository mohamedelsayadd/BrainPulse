import 'package:brain_pulse/core/api/auth_api_service.dart';

import 'package:brain_pulse/core/helpers/shared_pref_helper/shared_pref_helper.dart';
import 'package:brain_pulse/core/helpers/shared_pref_helper/shared_pref_keys.dart';
import 'package:brain_pulse/features/privacy_and_security/data/model/change_password_model.dart';
import 'package:brain_pulse/features/privacy_and_security/data/model/edit_doctor_model.dart';
import 'package:brain_pulse/features/privacy_and_security/data/repo/privacy_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/api/failure.dart';

class PrivacyRepoImple implements PrivacyRepo {
  AuthApiService authApiService;
  PrivacyRepoImple({required this.authApiService});
  @override
  Future<Either<Failure, ChangePasswordModel>> changepassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    try {
      var data =
          await authApiService.put(endpoint: "Auth/change-Password", data: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword
      });
      return right(ChangePasswordModel.fromjson(data));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioException(e);
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteDoctor({required int id}) async {
    try {
      final success = await authApiService.delete(endpoint: 'Auth/$id');

      if (success) {
        return right(true);
      } else {
        return left(
            ServerFailure("Delete failed: unexpected server response."));
        ;
      }
    } on DioException catch (dioError) {
      print(
          '❌ DioException: ${dioError.response?.statusCode} - ${dioError.response?.data}');
      return left(ServerFailure.fromDioException(dioError));
    } catch (e) {
      print('❌ Unknown Exception: $e');
      return left(ServerFailure("Unknown error: $e"));
    }
  }

  @override
  Future<Either<Failure, EditDoctorModel>> editDoctor({
    required String name,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      final userId = await SharedPrefHelper.getInt(key: SharedPrefKeys.userId);

      if (userId == null || userId == 0) {
        print("❌ User ID not found, please login again.");
      } else {
        print("✅ User ID found: $userId");
      }

      var data = await authApiService.editdoctor(
        endpoint: "Auth/$userId",
        data: {
          "name": name,
          "email": email,
          "phoneNumber": phoneNumber,
        },
      );
      print("the response : ${EditDoctorModel.fromjson(data)}");
      return right(EditDoctorModel.fromjson(data));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioException(e);
      return left(failure);
    }
  }
}
