import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_store/data/shared_preferences/cache_helper.dart';
import 'package:mini_store/presentation/layouts/home_layout.dart';
import 'package:mini_store/shared/bloc_observer.dart';
import 'package:mini_store/shared/global_value.dart';

import 'business_logic/home_layout_cubit/home_layout_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  LOGIN_TOKEN = await CacheHelper.getData(CacheHelperKeys.token)?? "";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF003366), // The primary color of your app
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFFDAA520),), // The accent color used for buttons, selection, etc.

        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          // ... more text styles
        ),

        appBarTheme: const AppBarTheme(
          color: Color(0xFF1E3A8A),
          elevation: 4,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),

        ),

        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFEF6C00),
          textTheme: ButtonTextTheme.primary,
        ),

        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1E3A8A)),
          ),
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // Background color of the bottom navigation bar
          selectedItemColor: Color(0xFFEF6C00), // Selected item color
          unselectedItemColor: Colors.black54, // Unselected item color
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),

      ),
      home: BlocProvider(
  create: (context) => HomeLayoutCubit(),
  child: HomeLayout(),
),
    );
  }
}
