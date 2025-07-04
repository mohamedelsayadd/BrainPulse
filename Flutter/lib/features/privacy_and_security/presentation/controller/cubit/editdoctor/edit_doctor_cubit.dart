import 'package:brain_pulse/features/privacy_and_security/data/repo/privacy_repo_imple.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/controller/cubit/editdoctor/edit_doctor_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDoctorCubit extends Cubit<EditDoctorState> {
  EditDoctorCubit({required this.privacyRepoImple})
      : super(InitialEditDoctorState());
  PrivacyRepoImple privacyRepoImple;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  GlobalKey<FormState> editkeyform = GlobalKey();
  bool isLoading = false;
  Future<void> editDoctorCubit() async {
    isLoading = true;
    emit(LoadingEditDoctorState());
    var value = await privacyRepoImple.editDoctor(
        name: name.text, email: email.text, phoneNumber: phoneNumber.text);
    return value.fold((error) {
      print(error);
      isLoading = false;
      emit(FailureEditDoctorState(errormsg: error.errorMessage));
    }, (register) {
      isLoading = false;
      emit(LoadedEditDoctorState());
    });
  }

  void editDoctorvalidate({
    required String oldName,
    required String oldEmail,
    required String oldPhone,
  }) {
    if (editkeyform.currentState!.validate()) {
      final isSame = name.text.trim() == oldName.trim() &&
          email.text.trim() == oldEmail.trim() &&
          phoneNumber.text.trim() == oldPhone.trim();

      if (isSame) {
        emit(FailureEditDoctorState(errormsg: "No changes detected."));
        return;
      }

      editDoctorCubit();
    }
  }
}
