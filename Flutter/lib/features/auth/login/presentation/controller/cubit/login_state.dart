abstract class LoginState {}

class InitialLoginSate extends LoginState {}

class LoadingLoginSate extends LoginState {}

class LoadedLoginSate extends LoginState {}

class ErrorLoginState extends LoginState {
  final String errormsg;

  ErrorLoginState({required this.errormsg});
}
