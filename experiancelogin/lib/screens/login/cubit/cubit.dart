import 'package:experiancelogin/models/user_model.dart';
import 'package:experiancelogin/screens/login/cubit/state.dart';
import 'package:experiancelogin/shared/network/network/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/network/enboints.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context)=> BlocProvider.of(context);
  late UserModel userModel;
  void userLogin({
  required String email,
    required String password,
}){
    emit(LoginLoadingState());
    DioNetwork.postData(url: Login, data:{
      'email':email,
      'password':password,
    }).then((value){
      print(value.data);
      userModel=UserModel.fromJson(value.data);
      print(userModel.status);
      emit(LoginSuccessState(userModel));
    }).catchError((error) {
      print(error);
      emit(LoginErrorState(error.toString()));
    });
  }
}