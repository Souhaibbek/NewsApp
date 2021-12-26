import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/newslayout/cubit/state.dart';
import 'package:newsapp/modules/business_news.dart';
import 'package:newsapp/modules/sciences_news.dart';
import 'package:newsapp/modules/sports_news.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());


  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens=
  [
    BusinessScreen(),
    SportsScreen(),
    SciencesScreen(),
  ];

  List<BottomNavigationBarItem> botNavBarItems=
  [
    BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business',),
    BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sports',),
    BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Sciences',),
  ];

  void  changeBotNavBar(index){
    currentIndex = index;
    switch(index){
      case 1 : getSports();
      break;
      case 2 : getScience();
      break;
    }

    emit(NewsBottomNavState());
  }

  List<dynamic> business=[];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());

    if(business.length==0){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'business',
        'apiKey':'e813a94a5c3c4bf3833f1e536e80fc0a',
      }).then((value) {
        business = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      } ).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }
    else { emit(NewsGetBusinessSuccessState());}


  }

  List<dynamic> sports=[];

  void getSports(){
    emit(NewsGetSportsLoadingState());
    if (sports.length==0){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'e813a94a5c3c4bf3833f1e536e80fc0a',
      }).then((value) {
        sports = value.data['articles'];

        emit(NewsGetSportsSuccessState());
      } ).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });

    }
    else {emit(NewsGetSportsSuccessState());}


  }

  List<dynamic> science=[];

  void getScience(){
    emit(NewsGetSciencesLoadingState());

    if(science.length==0){ DioHelper.getData(url: 'v2/top-headlines', query: {
      'country':'eg',
      'category':'science',
      'apiKey':'e813a94a5c3c4bf3833f1e536e80fc0a',
    }).then((value) {
      science = value.data['articles'];
      emit(NewsGetSciencesSuccessState());
    } ).catchError((error) {
      print(error.toString());
      emit(NewsGetSciencesErrorState(error.toString()));
    });

    }
    else {emit(NewsGetSciencesSuccessState());}

  }

  bool isDark=false;

  void changeAppMode({bool? fromShared}){

    if(fromShared != null){
      isDark=fromShared;
      emit(NewsChangeAppModeState());
    }
    else  {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){emit(NewsChangeAppModeState());});
    }



  }

  List<dynamic> search=[];

  void getSearch(String value){


    emit(NewsGetSearchLoadingState());
    search=[];

    DioHelper.getData(url: 'v2/everything', query: {
      'q':'$value',
      'apiKey':'e813a94a5c3c4bf3833f1e536e80fc0a',
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    } ).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });


  }

}