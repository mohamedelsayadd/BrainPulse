abstract class EditDoctorState {}

class InitialEditDoctorState extends EditDoctorState {}

class LoadingEditDoctorState extends EditDoctorState {}

class LoadedEditDoctorState extends EditDoctorState {}

class FailureEditDoctorState extends EditDoctorState {
  final String errormsg;

  FailureEditDoctorState({required this.errormsg});
}
