import 'package:experiancelogin/models/user_model.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final UserModel model;

  RegisterSuccessState(this.model);
}
class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);
}