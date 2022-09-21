import 'package:api/component/component/component.dart';
import 'package:api/layout/shop_app/cubit/cubit.dart';
import 'package:api/layout/shop_app/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var model = ShopCubit.get(context).userModel.data;
          nameController.text = model.name;
          emailController.text = model.email;
          phoneController.text = model.phone;
          return SingleChildScrollView(
            child: ConditionalBuilder(
              condition: ShopCubit.get(context).userModel != null,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is ShopLoadingUpdateUserState)
                        LinearProgressIndicator(
                          color: Colors.green,
                        ),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 52.0,
                        child: CircleAvatar(
                          child: Image(image: AssetImage("assets/images/mario.png"),fit: BoxFit.contain,height: 100.0,width: 150.0,),
                          radius: 50.0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        context,
                        isPassword: false,
                        controller: nameController,
                        type: TextInputType.name,
                        label: "Name",
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your Name';
                          }
                        },
                        prefix: Icon(Icons.person),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(
                        context,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: "Email",
                        isPassword: false,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your Email';
                          }
                        },
                        prefix: Icon(Icons.email),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(
                        context,
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: "Phone",
                        isPassword: false,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your Phone';
                          }
                        },
                        prefix: Icon(Icons.phone),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultButton(() {
                        if (formKey.currentState.validate()) {
                          ShopCubit.get(context).updateUserData(
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                          );
                        }
                      }, "Update", context),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultButton(() {
                        signOut(context);
                      }, "SignOut", context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
