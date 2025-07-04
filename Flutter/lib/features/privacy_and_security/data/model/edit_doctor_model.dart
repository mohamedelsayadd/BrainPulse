class EditDoctorModel {
  String? name;
  String? email;
  String? phoneNumber;
  EditDoctorModel(
      {required this.email, required this.name, required this.phoneNumber});
  factory EditDoctorModel.fromjson(Map<String, dynamic> json) {
    return EditDoctorModel(
        email: json["email"],
        name: json["name"],
        phoneNumber: json["phoneNumber"]);
  }
  Map<String, dynamic> tojson() {
    return {'name': name, 'email': email, 'phoneNumber': phoneNumber};
  }
}
