import 'package:flutter/material.dart';

void customSnackBar(
    {required BuildContext context,
    required String message,
    int durationInSec = 5,
    required String label,
    Color textColor = Colors.white,
    Color backgroundColor = Colors.redAccent,
    void Function()? onPressed}) {
  final snackBar = SnackBar(
    content: Text(
      '$message',
      style: TextStyle(color: textColor),
    ),
    duration: Duration(seconds: durationInSec),
    backgroundColor: backgroundColor,
    action: SnackBarAction(
      label: '$label',
      onPressed: onPressed ?? () {},
    ),
  );

  // Find the Scaffold in the widget tree and show the SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
