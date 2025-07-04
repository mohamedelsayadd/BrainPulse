class RegisterModel {
  String? email;
  String? password;
  String? phoneNumber;
  String? name;

  RegisterModel({
    this.email,
    this.password,
    this.phoneNumber,
    this.name,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    password = json['Password'];
    phoneNumber = json['PhoneNumber'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['PhoneNumber'] = this.phoneNumber;
    data['Name'] = this.name;
    return data;
  }
}
