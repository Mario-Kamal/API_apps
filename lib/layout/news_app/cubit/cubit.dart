import 'package:api/layout/news_app/cubit/states.dart';
import 'package:api/modules/news_app/business/business_screen.dart';
import 'package:api/modules/news_app/science/science_screen.dart';
import 'package:api/modules/news_app/sports/sports_screen.dart';
import 'package:api/modules/settings/settings_screen.dart';
import 'package:api/network/local/cached_helper.dart';
import 'package:api/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: "Business"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_esports), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "Settings"),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1)
      getSports();
    if (index == 2)
      getScience();
    emit(NewsBottomStates());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "business",
      "apikey": "bf2af7ac9557482a964be298de546888",
    }).then((value) {
      business = value.data["articles"];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetBusinessLoadingStates());
    if (sports.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apikey": "bf2af7ac9557482a964be298de546888",
      }).then((value) {
        sports = value.data["articles"];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else{
       emit(NewsGetSportsSuccessState());
    }
  }
  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetBusinessLoadingStates());
    if (science.length==0){
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "science",
        "apikey": "bf2af7ac9557482a964be298de546888",
      }).then((value) {
        science = value.data["articles"];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }
  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetBusinessLoadingStates());
    search = [];
    DioHelper.getData(url: "v2/everything",
        query: {
      "q": "$value",
      "apikey": "bf2af7ac9557482a964be298de546888",
    }).then((value) {
      search = value.data["articles"];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
  bool isDark = false;
  void changeAppMode({bool fromShared}){
    if(fromShared!=null) {
      isDark=fromShared;emit(NewsChangeAppModeState());
    } else {
      isDark = !isDark;
      CashedHelper.putData("isDark", isDark).then((value) {
        emit(NewsChangeAppModeState());
      });

    }

  }
}
