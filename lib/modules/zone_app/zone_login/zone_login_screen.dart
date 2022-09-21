
// ignore_for_file: must_be_immutable

import 'package:api/layout/zone_app/zone_app_layout.dart';
import 'package:api/modules/zone_app/zone_login/cubit/zone_login_cubit.dart';
import 'package:api/modules/zone_app/zone_login/cubit/zone_login_states.dart';
import 'package:api/modules/zone_app/zone_register/zone_register_screen.dart';
import 'package:api/network/local/cached_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:api/component/component/component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ZoneLoginScreen extends StatelessWidget {
  ZoneLoginScreen({Key key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ZoneLoginCubit(),
      child: BlocConsumer<ZoneLoginCubit, ZoneLoginState>(
        listener: (context, states) {
          if(states is ZoneLoginErrorState){
            showToast(msg: states.error, state: ToastState.ERROR);
          }else if(states is ZoneLoginSuccessState){
            CashedHelper.saveData(
                key: "uId",
                value: states.uId)
                .then((value) {
              navegateAndFinish(context, ZoneLayout());
            });
            showToast(msg: "Welcome to our Zone", state: ToastState.SUCCESS);
            navegateAndFinish(context, const ZoneLayout());
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
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Let's join our ",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          GradientText(
                            'Zone',
                            style: const TextStyle(
                              fontSize: 35.0,
                            ),
                            colors: const [
                              Colors.greenAccent,
                              Colors.pinkAccent,
                              Colors.teal,
                              //add mroe colors here.
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
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
                          prefix: const Icon(Icons.email),
                          isPassword: false),
                      const SizedBox(
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
                          prefix: const Icon(Icons.lock),
                          suffixIcon: ZoneLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            ZoneLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isPassword: ZoneLoginCubit.get(context).isPassword),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        builder: (context) => defaultButton(() {
                          if (formKey.currentState.validate()) {
                            ZoneLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        }, "Login", context),
                        condition: states is! ZoneLoginLoadingState,
                        fallback: (context) => const CircularProgressIndicator(),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account ?",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          TextButton(
                              onPressed: () {
                                navegateTo(context, ZoneRegisterScreen());
                              },
                              child: const Text(
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
      ),
    );
  }
}
