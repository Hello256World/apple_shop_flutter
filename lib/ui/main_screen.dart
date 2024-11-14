import 'dart:ui';
import 'package:apple_shop_flutter/bloc/category/category_bloc.dart';
import 'package:apple_shop_flutter/bloc/home/home_bloc.dart';
import 'package:apple_shop_flutter/data/constants.dart';
import 'package:apple_shop_flutter/ui/category_screen.dart';
import 'package:apple_shop_flutter/ui/home_screen.dart';
import 'package:apple_shop_flutter/ui/profile_screen.dart';
import 'package:apple_shop_flutter/ui/shopping_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'SB',
              fontSize: 10,
              color: CustomColor.blueColor,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'SB',
              fontSize: 10,
              color: Colors.black,
            ),
            unselectedItemColor: Colors.black,
            selectedItemColor: CustomColor.blueColor,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/profile.png'),
                activeIcon: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: CustomColor.blueColor,
                      blurRadius: 20,
                      spreadRadius: -7,
                      offset: Offset(0.0, 20),
                    ),
                  ]),
                  child: Image.asset('assets/images/active_profile.png'),
                ),
                label: 'حساب کاربری',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/shopping_card.png'),
                activeIcon: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: CustomColor.blueColor,
                      blurRadius: 20,
                      spreadRadius: -7,
                      offset: Offset(0.0, 20),
                    ),
                  ]),
                  child: Image.asset('assets/images/active_shopping_card.png'),
                ),
                label: 'سبد خرید',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/category.png'),
                activeIcon: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: CustomColor.blueColor,
                      blurRadius: 20,
                      spreadRadius: -7,
                      offset: Offset(0.0, 20),
                    ),
                  ]),
                  child: Image.asset('assets/images/active_category.png'),
                ),
                label: 'دسته بندی',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/home.png'),
                activeIcon: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: CustomColor.blueColor,
                      blurRadius: 20,
                      spreadRadius: -7,
                      offset: Offset(0.0, 20),
                    ),
                  ]),
                  child: Image.asset('assets/images/active_home.png'),
                ),
                label: 'خانه',
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: pageList(),
      ),
    );
  }

  List<Widget> pageList() {
    return [
      const ProfileScreen(),
      const ShoppingCardScreen(),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: const CategoryScreen(),
      ),
      BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomeScreen(),
      )
    ];
  }
}
