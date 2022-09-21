import 'package:api/component/component/component.dart';
import 'package:api/layout/shop_app/cubit/cubit.dart';
import 'package:api/layout/shop_app/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, states) {},
      builder: (context, states) {
          return Scaffold(
            appBar: AppBar(),
            body: ShopCubit.get(context).cartModel.data.isEmpty? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/images/11.png"),height: 120.0,width: 120.0,),
                SizedBox(height: 10.0,),
                Text("Please add your Cart ",style: Theme.of(context).textTheme.caption.copyWith(fontSize: 25),),
              ],
            ):ConditionalBuilder(
              condition: states is! ShopLoadingCartDataState,
              builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    children: [
                      buildCartItems(
                          ShopCubit.get(context).cartModel.data[index].product,context),
                    ],
                  ),
                  separatorBuilder: (context, index) => Divider(
                    height: 5.0,
                  ),
                  itemCount: ShopCubit.get(context).cartModel.data.length),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            )
          );

        }
    );
  }
}
