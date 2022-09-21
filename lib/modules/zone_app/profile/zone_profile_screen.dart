import 'package:api/component/component/component.dart';
import 'package:api/layout/zone_app/cubit/zone_cubit.dart';
import 'package:api/layout/zone_app/cubit/zone_states.dart';
import 'package:api/modules/zone_app/edit_profile/edit_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZoneCubit,ZoneStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ZoneCubit.get(context).userModel;
        return  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    height: 380,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image(
                              image: CachedNetworkImageProvider(
                                  "${model.cover}"),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 290.0,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            foregroundImage: CachedNetworkImageProvider(
                                "${model.profile}"),
                            radius: 95,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Text("${model.name}",style: Theme.of(context).textTheme.caption,),
                  SizedBox(height: 5.0,),
                  Text("${model.bio}",style: TextStyle(fontSize: 20,color: Colors.white38),),
                ],
              ),
              SizedBox(height: 30.0,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(onTap: (){},
                    child: Column(children: [
                      Text("26",style: Theme.of(context).textTheme.caption,),
                      SizedBox(height: 5.0,),
                      Text("Posts",style: TextStyle(fontSize: 18,color: Colors.white38),),
                    ],),),
                  ),
                  Expanded(
                    child: InkWell(onTap: (){},
                    child: Column(children: [
                      Text("100",style: Theme.of(context).textTheme.caption,),
                      SizedBox(height: 5.0,),
                      Text("Friends",style: TextStyle(fontSize: 18,color: Colors.white38),),
                    ],),),
                  ),
                  Expanded(
                    child: InkWell(onTap: (){},
                    child: Column(children: [
                      Text("1M",style: Theme.of(context).textTheme.caption,),
                      SizedBox(height: 5.0,),
                      Text("Followers",style: TextStyle(fontSize: 18,color: Colors.white38),),
                    ],),),
                  ),
                  Expanded(
                    child: InkWell(onTap: (){},
                    child: Column(children: [
                      Text("1",style: Theme.of(context).textTheme.caption,),
                      SizedBox(height: 5.0,),
                      Text("Following",style: TextStyle(fontSize: 18,color: Colors.white38),),
                    ],),),
                  ),
                ],
              ),
              SizedBox(height: 30.0,),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: (){}, child: Text('Edit Profile',style: TextStyle(fontSize: 20,color: Colors.black),),clipBehavior: Clip.antiAliasWithSaveLayer,style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size.square(50)),backgroundColor: MaterialStateProperty.all(Colors.grey)),)),
                  SizedBox(width: 10.0,),
                  OutlinedButton(onPressed: (){navegateTo(context, EditProfileScreen());}, child: Icon(IconlyBroken.edit,size: 30,color: Colors.black),style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size.square(50)),backgroundColor: MaterialStateProperty.all(Colors.grey)),),
                ],
              ),

            ],
          ),
        );
      },
    );
  }
}
