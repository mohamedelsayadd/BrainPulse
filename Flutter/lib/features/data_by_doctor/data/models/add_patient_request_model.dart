import 'package:json_annotation/json_annotation.dart';
part 'add_patient_request_model.g.dart';

@JsonSerializable()
class AddPatientRequestModel {
  String? name;
  String? phoneNumber;
  int? age;
  double? gpd;
  double? grda;
  double? ipd;
  double? irda;
  double? seizure;
  double? other;
  final String Notes;

  AddPatientRequestModel(
      {this.name,
      this.phoneNumber,
      this.age,
      this.gpd,
      this.grda,
      this.ipd,
      this.irda,
      this.seizure,
      this.other,
      required this.Notes});

  Map<String, dynamic> toJson() => _$AddPatientRequestModelToJson(this);
}
