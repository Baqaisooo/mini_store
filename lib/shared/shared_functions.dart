
import 'package:flutter/material.dart';

import '../presentation/modules/login_screen.dart';

void navigateTo(context, screen){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}