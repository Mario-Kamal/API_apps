import 'package:api/models/shop_app/login_model.dart';
import 'package:api/modules/shop_app/register/cubit/states.dart';
import 'package:api/network/end_points.dart';
import 'package:api/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState>{
  ShopLoginModel loginModel;
  ShopRegisterCubit():super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: Register, data: {'name':name,'email':email,'password':password,'phone':phone}).then((value) {
      print(value.data);

      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility;
  bool isPassword = false;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ?Icons.visibility_off:Icons.visibility;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
