import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/features/auth/register/data/repo/register_repo_imple.dart';
import 'package:brain_pulse/features/auth/register/presentation/controller/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.registerRepoImple})
      : super(InitialRegisterState());
  RegisterRepoImple registerRepoImple;
  TextEditingController name = TextEditingController();
  //TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> registerkeyform = GlobalKey();
  bool isLoading = false;
  String? confirmPasswordError;
  Future<void> registerUserCubit() async {
    isLoading = true;
    emit(LoadingRegisterState());
    var value = await registerRepoImple.register(
        email: email.text,
        password: password.text,
        phone: phone.text,
        name: name.text);
    return value.fold((error) {
      print(error);
      isLoading = false;
      emit(FailuerRegisterState(errormsg: error.errorMessage));
    }, (register) {
      isLoading = false;
      emit(LoadedRegisterState());
    });
  }

  void registervalidate() {
    if (!confirmpasswordValidate()) {
      emit(FailuerRegisterState(errormsg: 'Passwords do not match!'.tr()));
      return;
    }

    if (registerkeyform.currentState!.validate()) {
      registerUserCubit();
    }
  }

  bool confirmpasswordValidate() {
    if (password.text != confirmpassword.text) {
      confirmPasswordError = 'Passwords do not match!'.tr();
      emit(InitialRegisterState());
      return false;
    }
    confirmPasswordError = null;
    return true;
  }
}
