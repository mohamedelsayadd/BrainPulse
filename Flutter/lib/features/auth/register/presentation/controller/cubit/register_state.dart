abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class LoadedRegisterState extends RegisterState {}

class FailuerRegisterState extends RegisterState {
  final String errormsg;
  FailuerRegisterState({required this.errormsg});
}

