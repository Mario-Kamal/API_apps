import 'package:api/component/component/component.dart';
import 'package:api/layout/shop_app/shop_layout.dart';
import 'package:api/modules/shop_app/login/cubit/cubit.dart';
import 'package:api/modules/shop_app/register/cubit/cubit.dart';
import 'package:api/modules/shop_app/register/cubit/cubit.dart';
import 'package:api/modules/shop_app/register/cubit/cubit.dart';
import 'package:api/modules/shop_app/register/cubit/cubit.dart';
import 'package:api/modules/shop_app/register/cubit/states.dart';
import 'package:api/network/local/cached_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
        listener: (context,states){
          if (states is ShopRegisterSuccessState) {
            if (states.loginModel.status) {
              CashedHelper.saveData(
                  key: "token", value: states.loginModel.data.token)
                  .then((value) {
                token = states.loginModel.data.token;
                navegateAndFinish(context, ShopLayout());
              });
            } else {
              showToast(msg: states.loginModel.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (context,states){
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Register",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Register Now to get offers",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(context,
                          controller: nameController,
                          type: TextInputType.name, validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your name ';
                            }
                          },
                          label: "Name",
                          prefix: Icon(Icons.person),
                          isPassword: false),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFormField(context,
                          controller: emailController,
                          type: TextInputType.emailAddress, validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your email address';
                            }
                          },
                          label: "Email Address",
                          prefix: Icon(Icons.email),
                          isPassword: false),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFormField(context,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                          },
                          label: "Password",
                          prefix: Icon(Icons.lock),
                          suffixIcon: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(context,
                          controller: phoneController,
                          type: TextInputType.phone, validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone ';
                            }
                          },
                          label: "Phone",
                          prefix: Icon(Icons.phone),
                          isPassword: false),
                      SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        builder: (context) => defaultButton(() {
                          if (formKey.currentState.validate()) {
                            ShopRegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        }, "Register", context),
                        condition: states is! ShopRegisterLoadingState,
                        fallback: (context) => CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
