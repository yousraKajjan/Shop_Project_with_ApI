// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

// https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca

import 'package:experiancelogin/screens/login/login_screen.dart';
import 'package:experiancelogin/shared/network/local/cache_helper.dart';
import 'package:experiancelogin/shared/widgets/widgets.dart';

void signOut(context) {
  CashHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value == true) {
      navigatAndFinishTo(
        context,
        LoginScreen(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
