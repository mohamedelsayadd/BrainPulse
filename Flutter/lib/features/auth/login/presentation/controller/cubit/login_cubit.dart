import 'dart:developer';

import 'package:brain_pulse/core/helpers/shared_pref_helper/shared_pref_helper.dart';
import 'package:brain_pulse/core/helpers/shared_pref_helper/shared_pref_keys.dart';
import 'package:brain_pulse/core/api/dio_factory.dart';
import 'package:brain_pulse/core/network/dio_factory.dart';
import 'package:brain_pulse/features/auth/login/data/repo/login_repo_imple.dart';
import 'package:brain_pulse/features/auth/login/presentation/controller/cubit/login_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginRepoImple}) : super(InitialLoginSate());
  LoginRepoImple loginRepoImple;
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> loginkeyform = GlobalKey();
  Map<String, dynamic> decodedToken = {};
  bool isloading = false;
  String? username;
  String? emailaddress;
  String? phone;

  Future<void> loginUserCubit() async {
    emit(LoadingLoginSate());
    isloading = true;
    var value = await loginRepoImple.postlogin(
        email: email.text, password: password.text);
    return value.fold((error) {
      isloading = false;
      emit(ErrorLoginState(errormsg: error.errorMessage));
    }, (response) async {
      try {
        await SharedPrefHelper.setData(
            key: SharedPrefKeys.token, value: response.token);
        log("Token Saved : ${response.token}");
        DioFactory2.setTokenIntoHeaderAfterLogin(response.token);
        await saveUserToken(response.token);
        await SharedPrefHelper.setData(
            key: SharedPrefKeys.name, value: response.doctor.name);
        await SharedPrefHelper.setData(
            key: SharedPrefKeys.email, value: response.doctor.email);
        await SharedPrefHelper.setData(
            key: SharedPrefKeys.phoneNumber,
            value: response.doctor.phoneNumber);

        decodedToken = JwtDecoder.decode(response.token);
        var userIdDynamic = decodedToken['nameid'];
        int userId = 0;
        if (userIdDynamic is String) {
          userId = int.tryParse(userIdDynamic) ?? 0;
        } else if (userIdDynamic is int) {
          userId = userIdDynamic;
        }
        print("✅ Extracted userId from token: $userId");
        await SharedPrefHelper.setData(
            key: SharedPrefKeys.userId, value: userId);
        print("✅ Saved userId in SharedPrefs: $userId");
        isloading = false;
        emit(LoadedLoginSate());
      } catch (e) {
        isloading = false;
        emit(ErrorLoginState(errormsg: 'Token save or decode error: $e'));
      }
    });
  }

  void loginvalidate() {
    if (loginkeyform.currentState!.validate()) {
      loginUserCubit();
    }
  }

  Future<void> checkLoginStatus() async {
    final token = await SharedPrefHelper.getString(key: SharedPrefKeys.token);
    log("Retrieved Token: $token");
    if (token.isNotEmpty) {
      if (!JwtDecoder.isExpired(token)) {
        decodedToken = JwtDecoder.decode(token);
        emit(LoadedLoginSate());
        await DioFactory.setToken(token);
      } else {
        await SharedPrefHelper.removeData(key: SharedPrefKeys.token);
        emit(InitialLoginSate());
      }
    } else {
      emit(InitialLoginSate());
    }
  }

  Future<void> loadUserDataFromPrefs() async {
    username = await SharedPrefHelper.getString(key: SharedPrefKeys.name);
    emailaddress = await SharedPrefHelper.getString(key: SharedPrefKeys.email);
    phone = await SharedPrefHelper.getString(key: SharedPrefKeys.phoneNumber);
  }

  Future<void> updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    await SharedPrefHelper.setData(key: SharedPrefKeys.name, value: name);
    await SharedPrefHelper.setData(key: SharedPrefKeys.email, value: email);
    await SharedPrefHelper.setData(
        key: SharedPrefKeys.phoneNumber, value: phone);

    username = name;
    emailaddress = email;
    phone = phone;

    emit(LoadedLoginSate());
  }

  Future<void> logout() async {
    await SharedPrefHelper.removeData(key: SharedPrefKeys.token);
    await SharedPrefHelper.removeData(key: SharedPrefKeys.email);
    await SharedPrefHelper.removeData(key: SharedPrefKeys.name);
    await SharedPrefHelper.removeData(key: SharedPrefKeys.phoneNumber);
    DioFactory.clearToken();
    email.clear();
    password.clear();
    emit(InitialLoginSate());
  }

  // set token in header service
  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setData(key: SharedPrefKeys.token, value: token);
    await DioFactory.setToken(token);
    DioFactory2.setTokenIntoHeaderAfterLogin(token);
  }
}
