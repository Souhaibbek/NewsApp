import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:newsapp/layout/newslayout/cubit/cubit.dart';
import 'package:newsapp/layout/newslayout/cubit/state.dart';
import 'package:newsapp/shared/components/components.dart';

class SciencesScreen extends StatelessWidget {
  const SciencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context, state){
        var list=NewsCubit.get(context).science;
        return articleBuilder(list, context);
      },
    );
  }
}
