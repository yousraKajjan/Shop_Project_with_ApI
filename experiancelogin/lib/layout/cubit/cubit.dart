import 'package:experiancelogin/layout/cubit/states.dart';
import 'package:experiancelogin/screens/categories/cateogries_screen.dart';
import 'package:experiancelogin/screens/favorites/favorites_screen.dart';
import 'package:experiancelogin/screens/home/home_screen.dart';
import 'package:experiancelogin/screens/home/products.dart';
import 'package:experiancelogin/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
class HomeLayoutCubit extends Cubit<HomeLayoutStates>{
  HomeLayoutCubit() : super (HomeLayoutInitialState());
  static HomeLayoutCubit get(context) => BlocProvider.of(context);
  int index=0;
List<Widget> screens=[
  // HomeScreen(),
  ProductsScreen(),
  CategoriesScreen(),
  FavoritesScreen(),
  SettingsScreen(),
];
void changeIndex(int value){
  index=value;
  emit(ChangeBottomNavItemState());
}
}