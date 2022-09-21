import 'package:api/component/component/component.dart';
import 'package:api/layout/shop_app/cubit/cubit.dart';
import 'package:api/layout/shop_app/cubit/states.dart';
import 'package:api/modules/shop_app/cart/cart_screen.dart';
import 'package:api/modules/shop_app/search/search_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("SouQy",style: Theme.of(context).textTheme.caption,),
              actions: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      navegateTo(context, CartScreen());
                    }, icon: Icon(Icons.shopping_cart,size: 30,)),
                    IconButton(onPressed: (){
                      navegateTo(context, SearchScreen());
                    }, icon: Icon(Icons.search,size: 30,)),
                  ],
                )
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.green,
              height: 50,
              onTap: (index) {
                cubit.changeBottom(index);
              },
              items: cubit.bottomItems,

              animationCurve: Curves.fastOutSlowIn,
              index: cubit.currentIndex,
            ),
          );
        });
  }
}
