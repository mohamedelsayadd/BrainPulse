// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_patient_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPatientRequestModel _$AddPatientRequestModelFromJson(
        Map<String, dynamic> json) =>
    AddPatientRequestModel(
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      age: (json['age'] as num?)?.toInt(),
      gpd: (json['gpd'] as num?)?.toDouble(),
      grda: (json['grda'] as num?)?.toDouble(),
      ipd: (json['ipd'] as num?)?.toDouble(),
      irda: (json['irda'] as num?)?.toDouble(),
      seizure: (json['seizure'] as num?)?.toDouble(),
      other: (json['other'] as num?)?.toDouble(),
      Notes: json['Notes'] as String,
    );

Map<String, dynamic> _$AddPatientRequestModelToJson(
        AddPatientRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'age': instance.age,
      'gpd': instance.gpd,
      'grda': instance.grda,
      'ipd': instance.ipd,
      'irda': instance.irda,
      'seizure': instance.seizure,
      'other': instance.other,
      'Notes': instance.Notes,
    };
