abstract class DeleteDoctorState {}

class InitialDeleteDoctorState extends DeleteDoctorState {}

class LoadingDeleteDoctorState extends DeleteDoctorState {}

class LoadedDeleteDoctorState extends DeleteDoctorState {}

class FailureDeleteDoctorState extends DeleteDoctorState {
  final String errorMessage;

  FailureDeleteDoctorState(this.errorMessage);
}
