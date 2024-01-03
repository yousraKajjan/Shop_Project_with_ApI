import 'package:experiancelogin/models/change_favorites_model.dart';
import 'package:experiancelogin/models/user_model.dart';

abstract class HomeAppStates {}

class HomeAppInitialState extends HomeAppStates {}

//state Home
class HomeAppSuccessState extends HomeAppStates {}

class HomeAppLoadingState extends HomeAppStates {}

class HomeAppErrorState extends HomeAppStates {
  final String error;
  HomeAppErrorState(this.error);
}

//state Categories
class CategoriesSuccessState extends HomeAppStates {}

class CategorisErrorState extends HomeAppStates {}

//state ChangeFavourites
class ChangeFavouritesSuccessState extends HomeAppStates {
  final ChangeFavoritModle modle;
  ChangeFavouritesSuccessState(this.modle);
}

class ChangeFavouritesErrorState extends HomeAppStates {}

class ChangeFavouritesState extends HomeAppStates {}

//state GetFavourites
class GetFavouritesLoadingState extends HomeAppStates {}

class GetFavouritesSuccessState extends HomeAppStates {}

class GetFavouritesErrorState extends HomeAppStates {}

//state GetUserData
class GetUserDataLoadingState extends HomeAppStates {}

class GetUserDataSuccessState extends HomeAppStates {
  final UserModel? userModel;

  GetUserDataSuccessState(this.userModel);
}

class GetUserDataErrorState extends HomeAppStates {}

//state UpdatUser
class UpdatUserLoadingState extends HomeAppStates {}

class UpdatUserSuccessState extends HomeAppStates {
  final UserModel? userModel;

  UpdatUserSuccessState(this.userModel);
}

class UpdatUserErrorState extends HomeAppStates {}
