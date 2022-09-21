import 'package:api/component/component/component.dart';
import 'package:api/layout/shop_app/cubit/cubit.dart';
import 'package:api/layout/shop_app/cubit/states.dart';
import 'package:api/models/shop_app/change_favorites_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, states) {},
      builder: (context, states) {
        if (ShopCubit.get(context).favouriteModel.data.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/images/11.png"),height: 120.0,width: 120.0,),
                SizedBox(height: 10.0,),
                Text("Please add your Favourite Items",style: Theme.of(context).textTheme.caption.copyWith(fontSize: 25),),
              ],
            ),
          );
        } else {
          return ConditionalBuilder(
            condition: states is! ShopLoadingFavoritesDataState,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildListProduct(
                    ShopCubit.get(context).favouriteModel.data[index].product,
                    context),
                separatorBuilder: (context, index) => Divider(
                      height: 5.0,
                    ),
                itemCount: ShopCubit.get(context).favouriteModel.data.length),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
