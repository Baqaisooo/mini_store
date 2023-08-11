import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_store/business_logic/home_layout_cubit/home_layout_cubit.dart';
import 'package:mini_store/presentation/modules/login_screen.dart';
import 'package:mini_store/shared/global_value.dart';

import '../../shared/shared_functions/navigation.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, int>(
      listener: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        // TODO: implement listener
      },
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        // state here represent the index
        return Scaffold(
          appBar: AppBar(
            title: const Text("mini store"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart_outlined),
              ),
              LOGIN_TOKEN.isEmpty ?
              signInButton(context) :
              signoutButton(context)
            ],
          ),
          body: HomeLayoutCubit.bottomNavBarScreens[state],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.other_houses_outlined), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined), label: "Categoris"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: "favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_suggest_outlined),
                  label: "Settings"),
            ],
            onTap: (index) {
              BlocProvider.of<HomeLayoutCubit>(context).changeItem(index);
            },
            currentIndex: state,
          ),
        );
      },
    );
  }

  Widget signInButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        navigateTo(context, LoginScreen());
      },
      icon: const Icon(Icons.login),
    );
  }

  Widget signoutButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        navigateToWithReplace(context, HomeLayout());
      },
      icon: const Icon(Icons.logout),
    );
  }
}
