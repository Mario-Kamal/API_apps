import 'package:api/component/component/component.dart';
import 'package:api/layout/zone_app/cubit/zone_states.dart';
import 'package:api/models/zone_app/zone_user_model.dart';
import 'package:api/modules/chat_details/chat_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/zone_app/cubit/zone_cubit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZoneCubit,ZoneStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              builder:(context)=> ListView.separated(itemBuilder: (context, index) =>buildChatItem(context,ZoneCubit.get(context).users[index]),
                  separatorBuilder: (context, index) => const Divider(color: Colors.grey,),
                  itemCount: ZoneCubit.get(context).users.length),
              condition: ZoneCubit.get(context).users.isNotEmpty,
              fallback: (context)=>const Center(child:  CircularProgressIndicator()),
            ),
          );
        });
  }

  Widget buildChatItem(context,ZoneUserModel userModel) =>
      InkWell(
        onTap: (){
          navegateTo(context,  ChatDetailsScreen(userModel: userModel,));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 37,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  foregroundImage: CachedNetworkImageProvider(
                      userModel.profile),
                  radius: 35,
                ),
              ),
              const SizedBox(width: 20,),
              Text(userModel.name, style: Theme.of(context).textTheme.bodyText1
                  .copyWith(fontSize: 25,color: Colors.white),),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 35,)
            ],
          ),
        ),
      );
}
