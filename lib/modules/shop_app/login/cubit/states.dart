import 'package:api/models/shop_app/login_model.dart';

abstract class ShopLoginState {}
class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginSuccessState extends ShopLoginState{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginErrorState extends ShopLoginState{
  final String error;

  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopLoginState{}