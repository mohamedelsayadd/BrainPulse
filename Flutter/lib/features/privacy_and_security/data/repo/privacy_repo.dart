import 'package:brain_pulse/core/api/failure.dart';
import 'package:brain_pulse/features/privacy_and_security/data/model/change_password_model.dart';
import 'package:brain_pulse/features/privacy_and_security/data/model/edit_doctor_model.dart';
import 'package:dartz/dartz.dart';

abstract class PrivacyRepo {
  Future<Either<Failure, ChangePasswordModel>> changepassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword});
  Future<Either<Failure, bool>> deleteDoctor({required int id});
  Future<Either<Failure, EditDoctorModel>> editDoctor(
      {required String name,
      required String email,
      required String phoneNumber});
}
