import 'dart:async';

import 'package:mini_store/data/api_services/dio_helper.dart';
import 'package:mini_store/data/api_services/end_points.dart';
import 'package:mini_store/data/models/user_model.dart';
import 'package:mini_store/shared/global_value.dart';

import '../models/logout_model.dart';

class AuthRepository {

  Future<UserModel> checkLogin(String email, String pass) async {
    late UserModel user;
    await DioHelper.dioHelper.postData(
      url: LOGIN,
      data: {"email": email, "password": pass},
    ).then((response) {
      user = UserModel.fromJson(response.data);
      print(user.message);
    }).catchError((error) {
      print("Server Error" + error.toString());
    });
    return user;
  }



  Future<LogoutModel?> logout() async {
    late LogoutModel logoutModel;
    await DioHelper.dioHelper
        .postData(url: LOGOUT, data: {}, token: LOGIN_TOKEN)
        .then((response) {
          logoutModel = LogoutModel.fromJson(response.data);
    })
        .catchError((onError) {
          print("Server Error" + onError);
        });
    return logoutModel;
  }



  Future<UserModel> register(String name, String email, String phone, String password) async {
    late UserModel user;
    await DioHelper.dioHelper.postData(
      url: REGISTER,
      data: {"name":name, "email": email, "phone":phone, "password": password},
    ).then((response) {
      user = UserModel.fromJson(response.data);
    }).catchError((error) {
      print("Server Error" + error);
    });
    return user;
  }


}
