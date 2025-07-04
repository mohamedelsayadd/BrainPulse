import 'package:brain_pulse/core/api/failure.dart';
import 'package:brain_pulse/features/auth/register/data/model/register_model.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterRepo {
  Future<Either<Failure, RegisterModel>> register(
      {required String email,
      required String password,
      required String phone,
      required String name});
}

