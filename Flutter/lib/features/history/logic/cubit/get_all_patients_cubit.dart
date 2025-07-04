import 'package:brain_pulse/features/history/data/repo/get_all_patients_repo.dart';
import 'package:brain_pulse/features/history/logic/cubit/get_all_patients_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllPatientsCubit extends Cubit<GetAllPatientsState> {
  GetAllPatientsCubit(this._getAllPatientsRepo)
      : super(const GetAllPatientsState.initial());

  final GetAllPatientsRepo _getAllPatientsRepo;

  getAllPatients() async {
    emit(const GetAllPatientsState.loadingGetAllPatients());
    final response = await _getAllPatientsRepo.getAllPatients();
    response.when(
      success: (data) async {
        emit(GetAllPatientsState.successGetAllPatients(data));
      },
      failure: (message) {
        emit(GetAllPatientsState.errorGetAllPatients(errorMessage: message));
      },
    );
  }


  // delete patient
  void deletePatient(String id) async {
    emit(const GetAllPatientsState.loadingDeletePatient());
    final response = await _getAllPatientsRepo.deletePatient(id);
    response.when(
      success: (data) async {
        await getAllPatients();
        emit(const GetAllPatientsState.successDeletePatient());
      },
      failure: (message) {
        emit(GetAllPatientsState.errorDeletePatient(errorMessage: message));
      },
    );
  }
}
