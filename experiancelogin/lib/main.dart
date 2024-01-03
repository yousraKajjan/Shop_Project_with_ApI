import 'package:experiancelogin/cubit/bloc_observer.dart';
import 'package:experiancelogin/cubit/cubit.dart';
import 'package:experiancelogin/layout/home_layout.dart';
import 'package:experiancelogin/screens/login/login_screen.dart';
import 'package:experiancelogin/screens/onboard/on_board_screen.dart';
import 'package:experiancelogin/shared/constante/color.dart';
import 'package:experiancelogin/shared/network/local/cache_helper.dart';
import 'package:experiancelogin/shared/network/network/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioNetwork.DioInit();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget widget;
  bool onBoarding = CashHelper.getData(key: 'onBoarding') ??
      false; //if onBoarding= null => onBoarding=false;
  String token =
      CashHelper.getData(key: 'token') ?? ''; //if token= null => token='';
  print('token: $token');
  if (onBoarding) {
    if (token != '') {
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardScreen();
  }
  runApp(MyApp(
    startWidget: widget,
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startWidget, required this.token})
      : super(key: key);
  final Widget startWidget;
  final String token;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //if you use in all app work provide here => this is rules
      providers: [
        BlocProvider(
          create: (context) => HomeAppCubit()
            ..getHomeData(token: token)
            ..getGategoriesData(token: token)
            ..getFavorites(token: token)
            ..getUserData(token: token),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: generateMaterialColor(activeColor),
          fontFamily: 'Lato',
          canvasColor: Colors.white,
          textTheme: const TextTheme(
            labelLarge: TextStyle(
              color: activeColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              height: 2.9,
            ),
            labelSmall: TextStyle(
              color: darkColor,
              fontSize: 20,
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: activeColor,
            titleSpacing: 10.0,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 5.0,
            ),
            iconTheme: IconThemeData(
              color: darkColor,
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 60,
            selectedIconTheme: IconThemeData(
              color: activeColor,
            ),
            selectedItemColor: activeColor,
            unselectedItemColor: Colors.grey,
          ),
        ),
        home: startWidget,
        // home: HomeLayout(),
      ),
    );
  }
}

// colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// useMaterial3: true,