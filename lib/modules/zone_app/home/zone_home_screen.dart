import 'package:api/component/component/component.dart';
import 'package:api/layout/zone_app/cubit/zone_cubit.dart';
import 'package:api/layout/zone_app/cubit/zone_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZoneCubit, ZoneStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ZoneCubit.get(context).posts.isNotEmpty &&
              ZoneCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 37,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                foregroundImage: CachedNetworkImageProvider(
                                    ZoneCubit.get(context).userModel.profile),
                                radius: 35,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                                child: TextFormField(
                              controller: textController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "What's on your mind ?",
                                hintStyle: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            )),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2.0,
                        indent: 15.0,
                        endIndent: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          IconlyBroken.image,
                                          color: Colors.blueAccent,
                                          size: 30,
                                        )),
                                    const Text(
                                      "Image",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          IconlyBroken.location,
                                          color: Colors.redAccent,
                                          size: 30,
                                        )),
                                    const Text(
                                      "Tags",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          IconlyBroken.paper_plus,
                                          color: Colors.greenAccent,
                                          size: 30,
                                        )),
                                    const Text(
                                      "Document",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],

                        ),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItems(
                        ZoneCubit.get(context).posts[index], context, index),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 0,
                        ),
                    itemCount: ZoneCubit.get(context).posts.length),
              ],
            ),
          ),
          fallback: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // if(ZoneCubit.get(context).posts.isEmpty)
              //   Center(child: Text("Please Add Some Posts",style: TextStyle(fontSize: 30,color: Colors.white),)),
              if (state is ZoneGetPostsLoadingState)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}
