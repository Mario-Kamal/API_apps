import 'package:api/models/shop_app/home_model.dart';

class ChangeCartModel{
  bool status;
  dynamic message;
  ChangeCartModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}
class CartModel{
List<CartData> data=[];
CartModel.fromJson(Map<String,dynamic> json){
  if(json['data']!=null){
    json['data']['cart_items'].forEach((element){
      data.add(CartData.fromJson(element));
    });
  }}
}
class CartData{
int id;
int quantity;
ProductModel product;
CartData.fromJson(Map<String,dynamic> json){
  id=json['id'];
  quantity=json['quantity'];
  product=ProductModel.fromJson(json['product']);
}
}