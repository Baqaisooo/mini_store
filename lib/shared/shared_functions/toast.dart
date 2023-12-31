

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void customToast({
  required String message,
  Toast toastLength = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.BOTTOM,
  int timeInSecForIosWeb = 3,
  Color backgroundColor = Colors.red,
  Color textColor = Colors.white,
  double fontSize = 16
}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize
  );
}