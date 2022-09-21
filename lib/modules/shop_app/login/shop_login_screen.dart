import 'package:api/layout/shop_app/shop_layout.dart';
import 'package:api/modules/shop_app/login/cubit/cubit.dart';
import 'package:api/modules/shop_app/login/cubit/states.dart';
import 'package:api/modules/shop_app/register/register_screen.dart';
import 'package:api/network/local/cached_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:api/component/component/component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginState>(
      listener: (context, states) {
        if (states is ShopLoginSuccessState) {
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
      builder: (context, states) {
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
                      "Login",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Let's start shopping",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultTextFormField(context,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
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
                        suffixIcon: ShopLoginCubit.get(context).suffix,
                        suffixPressed: () {
                          ShopLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        isPassword: ShopLoginCubit.get(context).isPassword),
                    SizedBox(
                      height: 30.0,
                    ),
                    ConditionalBuilder(
                      builder: (context) => defaultButton(() {
                        if (formKey.currentState.validate()) {
                          ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      }, "Login", context),
                      condition: states is! ShopLoginLoadingState,
                      fallback: (context) => CircularProgressIndicator(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ?",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        TextButton(
                            onPressed: () {
                              navegateTo(context, RegisterScreen());
                            },
                            child: Text(
                              "Register now!",
                              style: TextStyle(fontSize: 20.0),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
