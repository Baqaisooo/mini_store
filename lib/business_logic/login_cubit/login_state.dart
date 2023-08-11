part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class changePasswordVisibilityState extends LoginState{}

class LoginingState extends LoginState{}

class LoggedInState extends LoginState{}

class LoginErrorState extends LoginState{
  String message;
  LoginErrorState(this.message);
}


class LoggingOut extends LoginState{}


class LoggedOut extends LoginState{}


class LogoutErrorState extends LoginState{
  String message;
  LogoutErrorState(this.message);
}
