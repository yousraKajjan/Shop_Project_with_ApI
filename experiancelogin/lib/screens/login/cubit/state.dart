import 'package:experiancelogin/models/user_model.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final UserModel model;

  LoginSuccessState(this.model);
}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}