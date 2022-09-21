import 'package:api/component/component/component.dart';
import 'package:api/models/shop_app/search_model.dart';
import 'package:api/modules/shop_app/search/cubit/cubit.dart';
import 'package:api/modules/shop_app/search/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultTextFormField(context,
                          controller: searchController,
                          type: TextInputType.text,
                          label: "Search",
                          prefix: Icon(Icons.search),
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your search";
                            }
                            return null;
                          },
                          isPassword: false,
                          onChanged: (String text) {
                            SearchCubit.get(context).search(text);
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchSuccessState)
                        Flexible(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildListProduct(
                                      SearchCubit.get(context).model.data[index], context, isOldPrice: false),
                              separatorBuilder: (context, index) => Divider(height: 10.0,thickness: 2.0,color: Colors.green,),
                              itemCount:SearchCubit.get(context).model.data.length),
                        ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
