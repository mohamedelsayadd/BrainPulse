import 'dart:developer';

import 'package:brain_pulse/core/network/api_result.dart';
import 'package:brain_pulse/core/network/api_service.dart';
import 'package:brain_pulse/features/data_by_doctor/data/models/add_patient_request_model.dart';
import 'package:brain_pulse/features/data_by_doctor/data/models/send_point_request_model.dart';

class SendPointRepo {
  SendPointRepo(this._apiService);
  final ApiService _apiService;

  Future<ApiResult<dynamic>> sendDataByDoctor(
      SendPointRequestModel request) async {
    try {
      final response = await _apiService.sendDataByDoctor(request);
      return ApiResult.success(response);
    } catch (e) {
      log(e.toString());
      return ApiResult.failure(e.toString());
    }
  }
}

class AddPatientRepo {
  AddPatientRepo(this._apiService);
  final ApiService _apiService;

  Future<ApiResult> addPatient(AddPatientRequestModel request) async {
    try {
      final response = await _apiService.addPatient(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
