import 'package:api/component/component/component.dart';
import 'package:api/layout/news_app/cubit/cubit.dart';
import 'package:api/layout/news_app/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var list = NewsCubit.get(context).science;
          return articleBuilder(list,context);
        },
        listener: (context, state) {});
  }
}
