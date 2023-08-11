import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_store/data/models/user_model.dart';
import 'package:mini_store/shared/global_value.dart';

import '../../data/repositories/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepository authRepository;

  LoginCubit(this.authRepository) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  //============================================

  bool isHiddenPassword = true;

  void changePasswordVisibility() {
    isHiddenPassword = !isHiddenPassword;
    emit(changePasswordVisibilityState());
  }

  bool loginLoading = false;

  void login(String email, String password) {
    loginLoading = !loginLoading;
    emit(LoginingState());

    authRepository.checkLogin(email, password).then((user) {
      loginLoading = !loginLoading;

      if (user.status && (user.data != null)) {
        LOGIN_TOKEN = user.data!.token;
        emit(LoggedInState());
      } else {
        emit(LoginErrorState(user.message));
      }
    }).catchError((onError) {
      print("LOCAL ERROR :: $onError");
    });
  }

  
  bool logoutLoading = false;
  
  void logout() {
    logoutLoading = !logoutLoading;
    emit(LoggingOut());
    authRepository.logout().then((logoutModel) {
      LOGIN_TOKEN = "";
      logoutLoading = !logoutLoading;
      if(!logoutModel!.status) {
        emit(LogoutErrorState(logoutModel.message));
      } else {
        emit(LoggedOut());
      }

    }).catchError((onError) {
      emit(LogoutErrorState(onError));
        print("LOCAL ERROR :: $onError");
    });
  }
}
