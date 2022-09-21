
import 'package:api/modules/zone_app/zone_login/cubit/zone_login_states.dart';
import 'package:api/network/end_points.dart';
import 'package:api/network/remote/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZoneLoginCubit extends Cubit<ZoneLoginState> {
  // ZoneLoginModel loginModel;

  ZoneLoginCubit() : super(ZoneLoginInitialState());

  static ZoneLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ZoneLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      emit(ZoneLoginSuccessState(value.user.uid));
    }).catchError((error){
      emit(ZoneLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = false;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ZoneChangePasswordVisibilityState());
  }
}
