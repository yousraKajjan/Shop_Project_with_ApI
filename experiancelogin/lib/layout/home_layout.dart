import 'package:experiancelogin/layout/cubit/cubit.dart';
import 'package:experiancelogin/layout/cubit/states.dart';
import 'package:experiancelogin/screens/search/search_screen.dart';
import 'package:experiancelogin/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutCubit(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Shop App'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    navigatTo(context, SearchSceen());
                  },
                  icon: Icon(Icons.search),
                )
              ],
            ),
            body: cubit.screens[cubit.index],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.index, //to select item
              onTap: (value) {
                cubit.changeIndex(value);
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          );
        },
      ),
    );
  }
}
