import 'package:api/models/zone_app/zone_user_model.dart';
import 'package:api/modules/zone_app/zone_register/cubit/zone_register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZoneRegisterCubit extends Cubit<ZoneRegisterState> {
  ZoneRegisterCubit() : super(ZoneRegisterInitialState());

  static ZoneRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(ZoneRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name, email: email, uId: value.user.uid, phone: phone);
    }).catchError((error) {
      emit(ZoneRegisterErrorState(error.toString()));
    });
  }

  ZoneUserModel model;

  void userCreate({
    @required String name,
    @required String email,
    @required String uId,
    @required String phone,
  }) {
    ZoneUserModel model = ZoneUserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      isEmailVerified: false,
      bio: "Write your bio .....",
      profile: "https://img.freepik.com/free-vector/gangster-skull-vector-illustration-head-skeleton-hat-with-cigar-mouth-criminal-mafia-concept-gang-emblems-tattoo-templates_74855-12236.jpg?size=338&ext=jpg&ga=GA1.2.2045067912.1642375139",
      cover: "https://img.freepik.com/free-vector/grim-reaper-with-scythe-night-cemetery-scene_107791-13585.jpg?size=626&ext=jpg&ga=GA1.2.2045067912.1642375139",
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(ZoneUserCreateSuccessState());
    }).catchError((error) {
      emit(ZoneUserCreateErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = false;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ZoneRegisterChangePasswordVisibilityState());
  }
}
