import 'package:api/layout/zone_app/cubit/zone_cubit.dart';
import 'package:api/layout/zone_app/cubit/zone_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZoneCubit,ZoneStates>(
      listener:(context,state){},
      builder:(context,state){
        var textController=TextEditingController();
        DateTime now = DateTime.now();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: const Icon(Icons.close,size: 30,),onPressed: (){
              Navigator.pop(context);
            },),
            title: ZoneCubit.get(context).title[2],
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: TextButton(onPressed: (){
                  if(ZoneCubit.get(context).postImage==null){
                    ZoneCubit.get(context).createPost(dateTime: DateFormat('yyyy-MM-dd – HH:mm').format(now).toString(), text: textController.text);
                  }else{
                    ZoneCubit.get(context).uploudPost(dateTime: DateFormat('yyyy-MM-dd – HH:mm').format(now).toString(), text: textController.text,);
                  }
                }, child: const Text('Post',style: TextStyle(fontSize: 25, color: Colors.white),)),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is ZoneCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if(state is ZoneCreatePostLoadingState)
                  const SizedBox(height: 20.0,),
                Row(
                  children: [
                     CircleAvatar(
                      radius: 37,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        foregroundImage: CachedNetworkImageProvider(
                            "${ZoneCubit.get(context).userModel.profile}"),
                        radius: 35,),
                    ),
                    const SizedBox(width: 15,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("${ZoneCubit.get(context).userModel.name}",style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 25,color: Colors.white),),
                            const SizedBox(width: 10.0,),
                            const Icon(IconlyBold.tick_square,size: 25,color: Colors.blue,),
                          ],
                        ),
                        const SizedBox(height: 10.0,),
                        Text(DateFormat('yyyy-MM-dd – HH:mm:a').format(now).toString(),style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15,color: Colors.white),),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Expanded(child: TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "What's on your mind ?",
                    hintStyle: TextStyle(fontSize: 20, color: Colors.white),

                  ),
                )),
                const SizedBox(height: 20,),
                if(ZoneCubit.get(context).postImage!=null)
                  Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                        image: FileImage(ZoneCubit.get(context).postImage),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 290.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              onPressed: () {
                                ZoneCubit.get(context).removePostImage();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        ZoneCubit.get(context).getPostImage();
                      }, child: Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: const [
                        Icon(IconlyBroken.image),
                        SizedBox(width: 5.0,),
                        Text('Image',style: TextStyle(fontSize: 25, color: Colors.white),),
                      ],)),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){}, child: Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: const [
                        Icon(IconlyBroken.location),
                        SizedBox(width: 5.0,),
                        Text('Tags',style: TextStyle(fontSize: 25, color: Colors.white),),
                      ],)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
