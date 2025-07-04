// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_patients_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientResponse _$PatientResponseFromJson(Map<String, dynamic> json) =>
    PatientResponse(
      patients: (json[r'$values'] as List<dynamic>)
          .map((e) => Patient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PatientResponseToJson(PatientResponse instance) =>
    <String, dynamic>{
      r'$values': instance.patients,
    };

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      phoneNumber: json['phoneNumber'] as String,
      dateOfCreation: DateTime.parse(json['dateOfCreation'] as String),
      doctorId: (json['doctorId'] as num).toInt(),
      history: PatientHistoryCollection.fromJson(
          json['history'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'phoneNumber': instance.phoneNumber,
      'dateOfCreation': instance.dateOfCreation.toIso8601String(),
      'doctorId': instance.doctorId,
      'history': instance.history,
    };

PatientHistoryCollection _$PatientHistoryCollectionFromJson(
        Map<String, dynamic> json) =>
    PatientHistoryCollection(
      records: (json[r'$values'] as List<dynamic>)
          .map((e) => MedicalRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PatientHistoryCollectionToJson(
        PatientHistoryCollection instance) =>
    <String, dynamic>{
      r'$values': instance.records,
    };

MedicalRecord _$MedicalRecordFromJson(Map<String, dynamic> json) =>
    MedicalRecord(
      recordId: json[r'$id'] as String,
      gpd: (json['gpd'] as num).toDouble(),
      grda: (json['grda'] as num).toDouble(),
      ipd: (json['ipd'] as num).toDouble(),
      irda: (json['irda'] as num).toDouble(),
      seizure: (json['seizure'] as num).toDouble(),
      other: (json['other'] as num).toDouble(),
      dateRecorded: DateTime.parse(json['dateRecorded'] as String),
      patientId: (json['patientId'] as num).toInt(),
    );

Map<String, dynamic> _$MedicalRecordToJson(MedicalRecord instance) =>
    <String, dynamic>{
      r'$id': instance.recordId,
      'gpd': instance.gpd,
      'grda': instance.grda,
      'ipd': instance.ipd,
      'irda': instance.irda,
      'seizure': instance.seizure,
      'other': instance.other,
      'dateRecorded': instance.dateRecorded.toIso8601String(),
      'patientId': instance.patientId,
    };
