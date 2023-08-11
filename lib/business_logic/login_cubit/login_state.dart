part of 'auth_cubit.dart';

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



class LoggingOutState extends LoginState{}


class LoggedOutState extends LoginState{}


class LogoutErrorState extends LoginState{
  String message;
  LogoutErrorState(this.message);
}





class RegisteringState extends LoginState{}


class RegisteredState extends LoginState{}


class RegisterErrorState extends LoginState{
  String message;
  RegisterErrorState(this.message);
}
