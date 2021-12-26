import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/newslayout/cubit/cubit.dart';
import 'package:newsapp/layout/newslayout/cubit/state.dart';
import 'package:newsapp/layout/newslayout/newslayout.dart';
import 'package:newsapp/shared/components/blocobserver.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool? isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>NewsCubit()..getBusiness()..changeAppMode(fromShared: isDark),

      child: BlocConsumer<NewsCubit , NewsStates>(
        listener: (context , state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.w600),),
              primarySwatch: Colors.deepOrange,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 20.0,),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,

                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black12,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.deepOrange,
                elevation: 20.0,),
              scaffoldBackgroundColor: Colors.blueGrey,

              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.blueGrey,
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: Colors.blueGrey,
                elevation: 0.0,
              ),
              textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.w600),),
            ),
            themeMode: NewsCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}





