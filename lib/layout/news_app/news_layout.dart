import 'package:api/component/component/component.dart';
import 'package:api/layout/news_app/cubit/cubit.dart';
import 'package:api/layout/news_app/cubit/states.dart';
import 'package:api/modules/news_app/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
            title: Text("News App"),
            actions: [
              IconButton(onPressed: (){
                navegateTo(context,SearchScreen());
              }, icon: Icon(Icons.search)),
              IconButton(onPressed: (){
                cubit.changeAppMode();
              }, icon: Icon(Icons.brightness_4_outlined))
            ],
          ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        },
      );
  }
}
