import 'package:brain_pulse/features/privacy_and_security/data/repo/privacy_repo_imple.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/controller/cubit/changepass/change_pass_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassCubit extends Cubit<ChangePassState> {
  ChangePassCubit({required this.privacyRepoImple})
      : super(InitialChangePassState());
  PrivacyRepoImple privacyRepoImple;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  GlobalKey<FormState> keyform = GlobalKey();
  bool isLoading = false;
  Future<void> changePassCubit() async {
    isLoading = true;
    emit(LoadingChangePassState());
    var value = await privacyRepoImple.changepassword(
        oldPassword: oldPassword.text,
        newPassword: newPassword.text,
        confirmNewPassword: confirmNewPassword.text);
    return value.fold((error) {
      print(error);
      isLoading = false;
      emit(FailureChangePassState(errormsg: error.errorMessage));
    }, (register) {
      isLoading = false;
      emit(LoadedChangePassState());
    });
  }

  void changepassvalidate() {
    if (keyform.currentState!.validate()) {
      changePassCubit();
    }
  }
}
