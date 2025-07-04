import 'package:brain_pulse/core/api/failure.dart';
import 'package:brain_pulse/features/auth/login/data/model/login_model.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> postlogin(
      {required String email, required String password});
}
