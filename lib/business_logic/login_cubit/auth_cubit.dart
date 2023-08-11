import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_store/data/models/user_model.dart';
import 'package:mini_store/shared/global_value.dart';

import '../../data/repositories/authentication_repository.dart';
import '../home_layout_cubit/home_layout_cubit.dart';

part 'login_state.dart';

class AuthCubit extends Cubit<LoginState> {
  AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(LoginInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

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
    })
        .catchError((onError) {
      print("LOCAL ERROR :: " + onError.toString());
    })
    ;
  }

  
  bool logoutLoading = false;
  
  void logout(context) {
    logoutLoading = !logoutLoading;
    emit(LoggingOutState());
    authRepository.logout().then((logoutModel) {

      logoutLoading = !logoutLoading;
      if(!logoutModel!.status) {
        print(logoutModel.message);
        emit(LogoutErrorState(logoutModel.message));
      } else {
        LOGIN_TOKEN = "";
        emit(LoggedOutState());

        HomeLayoutCubit.get(context).changeItem(0);
      }

    }).catchError((onError) {
      print("LOCAL ERROR :: $onError");
      emit(LogoutErrorState(onError));
    });
  }



  bool registerLoading = false;

  void register(String name, String email, String phone, String password) {
    registerLoading = !registerLoading;
    emit(RegisteringState());

    authRepository.register(name, email, phone, password).then((user) {
      registerLoading = !registerLoading;

      if (user.status) {
        LOGIN_TOKEN = user.data.token;
        emit(RegisteredState());
      } else {
        emit(RegisterErrorState(user.message));
      }
    }).catchError((onError) {
      print("LOCAL ERROR :: $onError");
    });
  }

}
