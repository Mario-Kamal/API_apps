import 'package:api/layout/shop_app/cubit/cubit.dart';
import 'package:api/layout/shop_app/cubit/states.dart';
import 'package:api/models/shop_app/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel.dataModel.data[index]),
            separatorBuilder: (context, index) => Divider(
                  height: 5.0,
                ),
            itemCount:
                ShopCubit.get(context).categoriesModel.dataModel.data.length);
      },
    );
  }

  Widget buildCatItem(dataModel model) => Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(children: [
          Image(
            image: NetworkImage(model.image),
            height: 150.0,
            width: 120.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(model.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
        ]),
      );
}
