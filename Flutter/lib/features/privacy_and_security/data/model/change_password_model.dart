class ChangePasswordModel {
  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;
  ChangePasswordModel(
      {required this.oldPassword,
      required this.newPassword,
      required this.confirmNewPassword});
  factory ChangePasswordModel.fromjson(Map<String, dynamic> json) {
    return ChangePasswordModel(
        oldPassword: json['oldPassword'],
        newPassword: json['newPassword'],
        confirmNewPassword: json['confirmNewPassword']);
  }
  Map<String, dynamic> tojson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }
}
