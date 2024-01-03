import 'package:experiancelogin/models/user_model.dart';
import 'package:experiancelogin/screens/register/cubit/state.dart';
import 'package:experiancelogin/shared/network/network/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/network/enboints.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  late UserModel userModel;
  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(RegisterLoadingState());
    DioNetwork.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      userModel = UserModel.fromJson(value.data);
      print(userModel.status);
      emit(RegisterSuccessState(userModel));
    }).catchError((error) {
      print(error);
      emit(RegisterErrorState(error.toString()));
    });
  }
}
