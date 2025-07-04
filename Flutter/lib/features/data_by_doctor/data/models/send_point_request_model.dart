import 'package:json_annotation/json_annotation.dart';

part 'send_point_request_model.g.dart';

@JsonSerializable()
class SendPointRequestModel {
  List? arr;

  SendPointRequestModel({this.arr});
  // from json
  factory SendPointRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SendPointRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$SendPointRequestModelToJson(this);
}

