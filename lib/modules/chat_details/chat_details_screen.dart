import 'package:api/layout/zone_app/cubit/zone_cubit.dart';
import 'package:api/layout/zone_app/cubit/zone_states.dart';
import 'package:api/models/zone_app/message_model.dart';
import 'package:api/models/zone_app/zone_user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class ChatDetailsScreen extends StatelessWidget {
  ZoneUserModel userModel;
   ChatDetailsScreen({Key key,this.userModel}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ZoneCubit.get(context).getMessage(receiverId: userModel.uId);
        return BlocConsumer<ZoneCubit,ZoneStates>(
          listener:(context,states){} ,
          builder:(context,states){
            DateTime now = DateTime.now();
            var messageController = TextEditingController();
            return Scaffold(
              appBar: AppBar(title:  Row(
                children: [
                  CircleAvatar(
                    foregroundImage: CachedNetworkImageProvider(
                        userModel.profile),
                    radius: 28,
                  ),
                  const SizedBox(width: 20,),
                  Text(userModel.name, style: Theme.of(context).textTheme.bodyText1
                      .copyWith(fontSize: 25,color: Colors.white),),
                ],
              ),),
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(itemBuilder:
                          (context,index){
                        var message=ZoneCubit.get(context).message[index];
                        if(ZoneCubit.get(context).userModel.uId==message.senderId)
                          return buildMyMessage(message);

                        return buildOtherMessage(message);
                      }
                          , separatorBuilder: (context,index)=>SizedBox(height: 10.0,), itemCount: ZoneCubit.get(context).message.length),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(

                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                            decoration: BoxDecoration(border: Border.all(
                                color: Colors.grey[800]
                            ),borderRadius: BorderRadius.circular(30.0),color: Colors.grey),
                            child: TextFormField(
                              controller: messageController,
                              style: TextStyle(color: Colors.black,),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write your message here ...',

                                  hintStyle: const TextStyle(color: Colors.black)
                              ),
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                          ZoneCubit.get(context).sendMessage(receiverId: userModel.uId, dateTime: DateFormat('yyyy-MM-dd – HH:mm')
                              .format(now)
                              .toString(), text: messageController.text);
                        }, icon: const Icon(IconlyBold.send,size: 30,),color: Colors.deepPurple,)
                      ],
                    )
                  ],
                ),
              ),
            );
          } ,
        );
      }
    );
  }
  Widget buildOtherMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(10),topStart: Radius.circular(10),bottomEnd: Radius.circular(10)),
        color: Colors.grey,
      ),
      child:  Text(model.text,style: const TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
    ),
  );
  Widget buildMyMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: const BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(topEnd: Radius.circular(10),topStart: Radius.circular(10),bottomStart: Radius.circular(10)),
        color: Colors.deepPurple,
      ),
      child:  Text(model.text,style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
    ),
  );
}
