import 'package:json_annotation/json_annotation.dart';

part 'get_all_patients_response.g.dart';

@JsonSerializable()
class PatientResponse {
  @JsonKey(name: r'$values')
  final List<Patient> patients;

  PatientResponse({required this.patients});

  factory PatientResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientResponseToJson(this);
}


@JsonSerializable()
class Patient {
  final int id;
  final String name;
  final int age;
  final String phoneNumber;
  final DateTime dateOfCreation;
  final int doctorId;

  final PatientHistoryCollection history;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.phoneNumber,
    required this.dateOfCreation,
    required this.doctorId,
    required this.history,
  });

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}

@JsonSerializable()
class PatientHistoryCollection {
  @JsonKey(name: r'$values')
  final List<MedicalRecord> records;

  PatientHistoryCollection({
    required this.records,
  });

  factory PatientHistoryCollection.fromJson(Map<String, dynamic> json) =>
      _$PatientHistoryCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$PatientHistoryCollectionToJson(this);
}

@JsonSerializable()
class MedicalRecord {
  @JsonKey(name: r'$id')
  final String recordId;

  final double gpd;
  final double grda;
  final double ipd;
  final double irda;
  final double seizure;
  final double other;
  final DateTime dateRecorded;
  final int patientId;

  MedicalRecord({
    required this.recordId,
    required this.gpd,
    required this.grda,
    required this.ipd,
    required this.irda,
    required this.seizure,
    required this.other,
    required this.dateRecorded,
    required this.patientId,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) =>
      _$MedicalRecordFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalRecordToJson(this);
}
