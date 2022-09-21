import 'package:api/component/component/component.dart';
import 'package:api/layout/zone_app/cubit/zone_cubit.dart';
import 'package:api/layout/zone_app/cubit/zone_states.dart';
import 'package:api/modules/zone_app/chat/zone_chat_screen.dart';
import 'package:api/modules/zone_app/post/add_post_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ZoneLayout extends StatelessWidget {
  const ZoneLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZoneCubit, ZoneStates>(listener: (context, state) {
      if (state is ZoneNewPostState) {
        navegateTo(context, const AddPostScreen());
      }
    }, builder: (context, state) {
      var cubit = ZoneCubit.get(context);
      return ConditionalBuilder(
        condition: ZoneCubit.get(context).userModel != null,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: cubit.currentIndex == 0
                ? Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black,
                        child:  CircleAvatar(
                          foregroundImage: NetworkImage(
                              cubit.userModel.profile),
                          radius: 28,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                             cubit.userModel.name,
                            style: const TextStyle(fontSize: 25),
                          ),
                          const Text(
                            "See your profile",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white38),
                          ),
                        ],
                      )
                    ],
                  )
                : cubit.title[cubit.currentIndex],
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IconButton(
                    onPressed: () {
                      navegateTo(context, const ChatScreen());
                      ZoneCubit.get(context).getAllUsers();
                    },
                    icon: const Icon(
                      IconlyBroken.activity,
                      size: 40,
                    )),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (int index) {
                cubit.changeBottom(index);
              },
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.home), label: ''),
                const BottomNavigationBarItem(
                    icon: const Icon(IconlyBroken.search), label: ''),
                const BottomNavigationBarItem(
                    icon: const Icon(IconlyBroken.upload), label: ''),
                const BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.setting), label: ''),
                BottomNavigationBarItem(
                    icon: CircleAvatar(
                      foregroundImage: CachedNetworkImageProvider(
                          "${ZoneCubit.get(context).userModel.profile}"),
                      radius: 25,
                    ),
                    label: ''),
              ],
            ),
          ),
        ),
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
