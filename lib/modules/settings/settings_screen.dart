import 'package:api/component/component/component.dart';
import 'package:api/layout/shop_app/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key key}) : super(key: key);
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(builder:
        (context,state){
      var model = ShopCubit.get(context).userModel.data;
      nameController.text=model.name;
      emailController.text=model.email;
      phoneController.text=model.phone;
      return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel!=null,
          fallback: (context)=>Center(child: CircularProgressIndicator()),
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultTextFormField(context,
                  controller:nameController,
                  type: TextInputType.name,
                  label: "Name",
                  validate:  (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your Name';
                    }
                  },
                  prefix: Icon(Icons.person),
                ),
                SizedBox(height: 10.0,),
                defaultTextFormField(context,
                  controller:emailController,
                  type: TextInputType.emailAddress,
                  label: "Email",
                  validate:  (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your Email';
                    }
                  },
                  prefix: Icon(Icons.email),
                ),
                SizedBox(height: 10.0,),
                defaultTextFormField(context,
                  controller:phoneController,
                  type: TextInputType.phone,
                  label: "Phone",
                  validate:  (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your Phone';
                    }
                  },
                  prefix: Icon(Icons.phone),
                ),
              ],
            ),
          ),
        );}, listener: (context,state){});
  }
}
