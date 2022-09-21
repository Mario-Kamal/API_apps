import 'package:api/component/component/component.dart';
import 'package:api/layout/zone_app/zone_app_layout.dart';
import 'package:api/modules/zone_app/zone_register/cubit/zone_register_cubit.dart';
import 'package:api/modules/zone_app/zone_register/cubit/zone_register_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

// ignore: must_be_immutable
class ZoneRegisterScreen extends StatelessWidget {
  ZoneRegisterScreen({Key key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ZoneRegisterCubit(),
      child: BlocConsumer<ZoneRegisterCubit,ZoneRegisterState>(
        listener: (context,states){
          if (states is ZoneRegisterSuccessState) {
            navegateAndFinish(context, ZoneLayout());
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
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Register Now to enter our ",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          GradientText(
                            'Zone',
                            style: TextStyle(
                              fontSize: 35.0,
                            ),
                            colors: [
                              Colors.greenAccent,
                              Colors.pinkAccent,
                              Colors.teal,
                              //add mroe colors here.
                            ],
                          ),
                        ],
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
                          suffixIcon: ZoneRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            ZoneRegisterCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: ZoneRegisterCubit.get(context).isPassword),
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
                            ZoneRegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        }, "Register", context),
                        condition: states is! ZoneRegisterLoadingState,
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
