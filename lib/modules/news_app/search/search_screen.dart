import 'package:api/component/component/component.dart';
import 'package:api/layout/news_app/cubit/cubit.dart';
import 'package:api/layout/news_app/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var list = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: defaultTextFormField(
                      context,
                      onChanged: (value) {
                        NewsCubit.get(context).getSearch(value);
                      },
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "Search musn't be empty";
                        }
                        return null;
                      },
                      label: "Search",
                      prefix: Icon(Icons.search),
                      isPassword: false
                    )),
                Expanded(child: articleBuilder(list, context, isSearch: true))
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
