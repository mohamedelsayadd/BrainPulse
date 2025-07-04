import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/features/privacy_and_security/data/repo/privacy_repo_imple.dart';
import 'package:brain_pulse/features/privacy_and_security/presentation/controller/cubit/deletedoctor/delete_doctor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDoctorCubit extends Cubit<DeleteDoctorState> {
  final PrivacyRepoImple privacyRepoImple;

  DeleteDoctorCubit({required this.privacyRepoImple})
      : super(InitialDeleteDoctorState());

  Future<void> deleteDoctor(int id) async {
    emit(LoadingDeleteDoctorState());

    final result = await privacyRepoImple.deleteDoctor(id: id);

    result.fold(
      (failure) => emit(FailureDeleteDoctorState(failure.errorMessage)),
      (success) {
        if (success) {
          emit(LoadedDeleteDoctorState());
        } else {
          emit(FailureDeleteDoctorState('Unknown error'.tr()));
        }
      },
    );
  }
}
