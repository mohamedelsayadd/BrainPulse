abstract class ChangePassState {}

class InitialChangePassState extends ChangePassState {}

class LoadingChangePassState extends ChangePassState {}

class LoadedChangePassState extends ChangePassState {}

class FailureChangePassState extends ChangePassState {
  final String errormsg;
  FailureChangePassState({required this.errormsg});
}
