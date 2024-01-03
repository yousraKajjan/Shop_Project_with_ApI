import 'package:experiancelogin/models/search_model.dart';
import 'package:experiancelogin/screens/search/cubit/state.dart';
import 'package:experiancelogin/shared/network/components/constans.dart';
import 'package:experiancelogin/shared/network/network/enboints.dart';
import 'package:experiancelogin/shared/network/network/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());
    DioNetwork.postData(token: token, url: SEARCH, data: {'text': text})
        .then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
