import 'package:api/models/shop_app/home_model.dart';

class ChangeSearchModel{
  bool status;
  String message;
  ChangeSearchModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}
class SearchModel{
  List<ProductModel> data=[];
  SearchModel.fromJson(Map<String,dynamic> json){
    if(json['data']!=null){
      json['data']['data'].forEach((element){
        data.add(ProductModel.fromJson(element));
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