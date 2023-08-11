import 'package:flutter/material.dart';

void navigateTo(BuildContext context, screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

void navigateToWithReplace(context, screen) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false);
}
