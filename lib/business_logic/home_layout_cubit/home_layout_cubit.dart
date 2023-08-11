import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_store/presentation/modules/categories_screen.dart';
import 'package:mini_store/presentation/modules/favorite_screen.dart';
import 'package:mini_store/presentation/modules/home_screen.dart';
import 'package:mini_store/presentation/modules/settings_screen.dart';



class HomeLayoutCubit extends Cubit<int> {
  HomeLayoutCubit() : super(0);

  static HomeLayoutCubit get(context) => BlocProvider.of<HomeLayoutCubit>(context);


  static const bottomNavBarScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];



  void changeItem(int index) {
    emit(index);
  }
}
