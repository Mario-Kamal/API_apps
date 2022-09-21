class ShopLoginModel {
  bool status;
  String message;
  UserData data;

  ShopLoginModel.fromJson(Map<String,dynamic>Json) {
    status =Json['status'];
    message =Json['message'];
    data =Json['data']!=null?UserData.fromJson(Json['data']):null;
  }
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  UserData.fromJson(Map<String,dynamic>Json) {
    id =Json['id'];
    name =Json['name'];
    email =Json['email'];
    phone =Json['phone'];
    image =Json['image'];
    points =Json['points'];
    credit =Json['credit'];
    token =Json['token'];
  }

}