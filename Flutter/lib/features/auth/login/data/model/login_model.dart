class LoginModel {
  final String token;
  final Doctor doctor;

  LoginModel({required this.token, required this.doctor});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        token: json['token'], doctor: Doctor.fromJson(json['doctor']));
  }
}

class Doctor {
  final String name;
  final String email;
  final String phoneNumber;

  Doctor({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
