import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_data_by_doctor_state.freezed.dart';

@freezed
class SendDataByDoctorState<T> with _$SendDataByDoctorState<T> {
  const factory SendDataByDoctorState.initial() = _Initial;
  const factory SendDataByDoctorState.loadingSendDataByDoctor() =
      LoadingSendDataByDoctor;
  const factory SendDataByDoctorState.successSendDataByDoctor(T data) =
      SuccessSendDataByDoctor<T>;
  const factory SendDataByDoctorState.failureSendDataByDoctor(
      {required String message}) = FailureSendDataByDoctor;

// add patient

  const factory SendDataByDoctorState.loadingAddPatient() = LoadingAddPatient;
  const factory SendDataByDoctorState.successAddPatient(T data) =
      SuccessAddPatient<T>;
  const factory SendDataByDoctorState.failureAddPatient(
      {required String message}) = FailureAddPatient;
}
