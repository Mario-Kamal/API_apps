import 'package:api/component/component/component.dart';
import 'package:api/models/shop_app/search_model.dart';
import 'package:api/modules/shop_app/search/cubit/states.dart';
import 'package:api/network/end_points.dart';
import 'package:api/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: Search, token: token, data: {'text': text})
        .then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
