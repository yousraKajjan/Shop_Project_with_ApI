import 'package:experiancelogin/cubit/state.dart';
import 'package:experiancelogin/models/categories_model.dart';
import 'package:experiancelogin/models/change_favorites_model.dart';
import 'package:experiancelogin/models/favourite_model.dart';
import 'package:experiancelogin/models/home_model.dart';
import 'package:experiancelogin/models/user_model.dart';
import 'package:experiancelogin/shared/network/components/constans.dart';
import 'package:experiancelogin/shared/network/network/enboints.dart';
import 'package:experiancelogin/shared/network/network/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppCubit extends Cubit<HomeAppStates> {
  HomeAppCubit() : super(HomeAppInitialState());

  static HomeAppCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  //favourite
  Map<int?, bool?> favourites = {};

  void getHomeData({
    required String token,
  }) {
    emit(HomeAppLoadingState());
    DioNetwork.getData(token: token, url: Home).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print('HomeData:');
      // printFullText(homeModel.toString());
      // print('the status is:');
      // print(homeModel!.status);
      // for (var element in homeModel!.data!.products!) {
      //   favourites.addAll({
      //     element.id: element.inFavorites,
      //   });
      // }
      for (var element in homeModel!.data!.products!) {
        favourites.addAll({
          element.id: element.inFavorites,
        });
      }
      print(favourites.toString());
      emit(HomeAppSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeAppErrorState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getGategoriesData({
    required String token,
  }) {
    DioNetwork.getData(token: token, url: GET_GATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print('the status is:');
      print(homeModel!.status);
      emit(CategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CategorisErrorState());
    });
  }

  ChangeFavoritModle? changeFavoritModle;
  void ChangeFavorites(int? productId) {
    favourites[productId] != favourites[productId];
    emit(ChangeFavouritesState());

    DioNetwork.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoritModle = ChangeFavoritModle.fromJson(value.data);
      print(value.data);
      if (changeFavoritModle!.status == false) {
        favourites[productId] != favourites[productId];
      } else {
        getFavorites(token: token);
      }
      emit(ChangeFavouritesSuccessState(changeFavoritModle!));
    }).catchError((error) {
      favourites[productId] != favourites[productId];

      emit(ChangeFavouritesErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites({
    required String token,
  }) {
    // emit(GetFavouritesLoadingState());
    DioNetwork.getData(token: token, url: FAVORITES).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      print('the status favourite is:');
      print(favoritesModel!.status);
      // printFullText(value.data.toString());

      emit(GetFavouritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavouritesErrorState());
    });
  }

  UserModel? userModel;

  void getUserData({
    required String token,
  }) {
    // emit(GetFavouritesLoadingState());
    DioNetwork.getData(token: token, url: PROFILE).then((value) {
      userModel = UserModel.fromJson(value.data);

      print('the status is:');
      print(userModel!.status);
      print(userModel!.data!.name);

      emit(GetUserDataSuccessState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }

  void UpdateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    DioNetwork.putData(url: UPDATE_PROFILE, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);

      print('the status is:');
      print(userModel!.status);
      print(userModel!.data!.name);

      emit(UpdatUserSuccessState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(UpdatUserErrorState());
    });
  }
}
