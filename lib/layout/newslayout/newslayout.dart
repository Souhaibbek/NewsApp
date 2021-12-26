import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/newslayout/cubit/cubit.dart';
import 'package:newsapp/layout/newslayout/cubit/state.dart';
import 'package:newsapp/modules/search.dart';
import 'package:newsapp/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){

      },
      builder: (context , state){
        NewsCubit cubit=NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                navigateTo(context,SearchScreen());
              }, icon: Icon(Icons.search)),
              IconButton(onPressed: ()
              {
               cubit.changeAppMode();
              }, icon: Icon(Icons.brightness_4_outlined),),
            ],
            title: Text('NewsScreen'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBotNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items:cubit.botNavBarItems,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
