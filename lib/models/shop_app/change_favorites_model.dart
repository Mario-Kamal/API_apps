import 'package:api/models/shop_app/home_model.dart';

class ChangeFavoritesModel{
  bool status;
  String message;
  ChangeFavoritesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}
class FavouriteModel{
  List<FavoriteData> data=[];
  FavouriteModel.fromJson(Map<String,dynamic> json){
    if(json['data']!=null){
      json['data']['data'].forEach((element){
        data.add(FavoriteData.fromJson(element));
      });
    }
  }

  }
class FavoriteData{
  dynamic id;
  ProductModel product;
  FavoriteData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    product=ProductModel.fromJson(json['product']);

  }
}