import 'package:api/layout/shop_app/cubit/cubit.dart';
import 'package:api/layout/shop_app/cubit/states.dart';
import 'package:api/models/shop_app/categories_model.dart';
import 'package:api/models/shop_app/home_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, states) {
        if (states is ShopSuccessChangeFavoritesState) {
          ShopCubit.get(context).getFavoritesData();
        }
      },
      builder: (context, states) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => productsBuilder(
                ShopCubit.get(context).homeModel,
                context,
                ShopCubit.get(context).categoriesModel),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsBuilder(
          HomeModel model, context, CategoriesModel categoriesModel) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  initialPage: 0,
                  height: 250.0,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.bounceInOut,
                  autoPlayInterval: Duration(seconds: 2),
                  reverse: false,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      height: 100,
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildCategoryItem(
                              categoriesModel.dataModel.data[index]),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 10.0,
                              ),
                          itemCount: categoriesModel.dataModel.data.length)),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Items",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.56,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                  model.data.products.length,
                  (index) => productsGridBuilder(
                      model.data.products[index], context, index),
                ))
          ],
        ),
      );

  Widget buildCategoryItem(dataModel dataModel) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(dataModel.image),
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          Container(
              color: Colors.black,
              width: 100,
              child: Text(
                dataModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ))
        ],
      );

  Widget productsGridBuilder(ProductModel model, context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
                Transform.rotate(
                    angle: (math.pi / 180) * 45,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.deepOrange),
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "-${model.discount.round()}\%",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavourites(model.id);
                          print(model.id);
                        },
                        icon: Icon(
                          ShopCubit.get(context).favourites[model.id]
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          size: 12,
                          color: Colors.red,
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      );
}
