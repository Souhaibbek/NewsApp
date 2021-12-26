import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/newslayout/cubit/cubit.dart';
import 'package:newsapp/layout/newslayout/cubit/state.dart';
import 'package:newsapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context,state){},
      builder:(context , state)
      {
        var list=NewsCubit.get(context).search;
        return Scaffold(
        appBar: AppBar(),
        body: Column(
          children:
          [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(label: 'Search', type: TextInputType.text, controller: searchController, prefix: Icons.search, validate: (value){
                if(value.isEmpty){
                  return 'Search must not be empty';
                }
                return null;
              },
                onChange: (value)
                {
                  NewsCubit.get(context).getSearch(value);
                }
              ),
            ),
            Expanded(child: articleBuilder(list, context,isSearch: true),),
          ],
        ),
      );
      },
    );
  }
}
