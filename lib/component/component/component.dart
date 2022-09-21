// ignore_for_file: constant_identifier_names

import 'package:api/layout/shop_app/cubit/cubit.dart';
import 'package:api/layout/zone_app/cubit/zone_cubit.dart';
import 'package:api/models/shop_app/home_model.dart';
import 'package:api/models/zone_app/comment_model.dart';
import 'package:api/models/zone_app/post_model.dart';
import 'package:api/modules/news_app/web/web_view_screen.dart';
import 'package:api/modules/shop_app/login/shop_login_screen.dart';
import 'package:api/network/local/cached_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

String uId = '';

Widget buildArticleItem(article, context) =>
    InkWell(
      onTap: () {
        navegateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,

              height: 120.0,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage("${article['urlToImage']}"),
                    fit: BoxFit.cover,
                  )),

              // child: CachedNetworkImage(imageUrl: "${article['urlToImage']}", fit: BoxFit.cover,placeholder: (context, url) =>

              //  const CircularProgressIndicator(),

              //   errorWidget: (context, url, error) => const Icon(Icons.error),),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
                child: SizedBox(
                  height: 120.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // CachedNetworkImage(imageUrl: "${article['urlToImage']}"),

                      Expanded(
                          child: Text("${article['title']}",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle1)),

                      Text("${article['publishedAt']}",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle2),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) =>
    ConditionalBuilder(
      condition: list.length > 0,
      fallback: (context) =>
      isSearch
          ? Container()
          : const Center(
        child: CircularProgressIndicator(),
      ),
      builder: (context) =>
          ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArticleItem(list[index], context),
              separatorBuilder: (context, index) =>
              const Divider(
                thickness: 5.0,
              ),
              itemCount: 10),
    );

void navegateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navegateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false,
  );
}

Widget defaultTextFormField(context, {
  onChanged,
  suffixIcon,
  suffixPressed,
  isPassword,
  @required controller,
  @required type,
  @required label,
  @required prefix,
  @required validate,
}) =>
    TextFormField(
      textAlign: TextAlign.start,
      onChanged: onChanged,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 15),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixPressed,
        )
            : null,
        prefixIcon: Icon(
          prefix,
          color: Colors.white,
          size: 30,
        ),
        labelText: "$label",
        floatingLabelStyle: const TextStyle(color: Colors.green),
        isDense: true,
        contentPadding: const EdgeInsets.all(20.0),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 5.0),
          gapPadding: 20.0,
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

Widget defaultButton(Function function, String text, context) =>
    ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            textStyle: Theme
                .of(context)
                .textTheme
                .subtitle1,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            fixedSize: const Size(250, 50),
            alignment: Alignment.center,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
        child: Text(text));

void showToast({@required String msg, @required ToastState state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseColor(state),
        textColor: Colors.white,
        fontSize: 20.0);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void signOut(context) {
  CashedHelper.removeData('token').then((value) {
    if (value) {
      navegateAndFinish(context, ShopLoginScreen());
    }
  });
}

String token = '';

Widget buildListProduct(ProductModel data, context, {isOldPrice = true}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Image(
                  image: NetworkImage(data.image),
                  height: 120.0,
                  width: 120.0,
                ),
                if (data.discount != 0 && isOldPrice)
                  Transform.rotate(
                      angle: (math.pi / 180) * 45,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.deepOrange),
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            "-${data.discount.round()}%",
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )))
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    data.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${data.price.round()}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      if (data.discount != 0 && isOldPrice)
                        Text(
                          '${data.oldPrice.round()}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavourites(data.id);
                            print(data.id);
                          },
                          icon: Icon(
                            ShopCubit
                                .get(context)
                                .favourites[data.id]
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            size: 12,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

Widget buildCartItems(ProductModel data,
    context,) {
  return Column(
    children: [
      Image(
        image: NetworkImage(data.image),
        height: 120.0,
        width: 120.0,
      ),
      const SizedBox(
        height: 20.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          const SizedBox(
            width: 20.0,
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
        ],
      )
    ],
  );
}

var commentController = TextEditingController();
DateTime now = DateTime.now();

Widget buildPostItems(PostModel model, context, index) =>
    Card(
      elevation: 10.0,
      margin: const EdgeInsets.all(10.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 37,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    foregroundImage: CachedNetworkImageProvider(
                        model.postProfileImage),
                    radius: 35,),
                ),
                const SizedBox(width: 15,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(ZoneCubit
                            .get(context)
                            .userModel
                            .name, style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 25),),
                        const SizedBox(width: 10.0,),
                        const Icon(IconlyBold.tick_square, size: 25,
                          color: Colors.blue,),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    Text(DateFormat(model.dateTime).format(now).toString(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 15),),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(IconlyBroken.more_circle, size: 40,),
                  onPressed: () {},)
              ],
            ),
          ),
          const Divider(thickness: 2.0, indent: 50.0, endIndent: 50.0,),
          SizedBox(width: double.infinity,
            child: Container(
              padding: const EdgeInsets.only(left: 10.0),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.text, style: Theme
                        .of(context)
                        .textTheme
                        .caption
                        .copyWith(
                        color: Colors.black, fontSize: 20, height: 1.3),),
                    if(model.postImage != '')
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image(
                            image: CachedNetworkImageProvider(
                                model.postImage),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 300.0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const Icon(
                  IconlyBroken.heart, size: 30, color: Colors.redAccent,),

                if(ZoneCubit.get(context).likes.isEmpty)
                  const Text(' 0 Likes',
                    style: TextStyle(fontSize: 20),),
                if(ZoneCubit.get(context).likes.isNotEmpty)
                  Text(' ${ZoneCubit.get(context).likes[index]} likes',
                    style: const TextStyle(fontSize: 20),),
                const Spacer(),
                const Icon(
                  IconlyBroken.chat, size: 30, color: Colors.orangeAccent,),
                if(ZoneCubit.get(context).comments.isEmpty)
                  const Text(' 0 Comments',
                    style: TextStyle(fontSize: 20),),
                if(ZoneCubit.get(context).comments.isNotEmpty)
                  Text(' ${ZoneCubit.get(context).comments} comments',
                    style: const TextStyle(fontSize: 20),),
              ],
            ),
          ),
          const Divider(thickness: 2.0, indent: 15.0, endIndent: 15.0,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    foregroundImage: CachedNetworkImageProvider(
                        ZoneCubit
                            .get(context)
                            .userModel
                            .profile),
                    radius: 30,),
                ),
                const SizedBox(width: 15.0,),
                Expanded(child: TextFormField(
                  controller: commentController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write a comment ...",
                    hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                )),
                IconButton(onPressed: () {
                  ZoneCubit.get(context).createComment(
                      dateTime: DateFormat('yyyy-MM-dd – HH:mm')
                          .format(now)
                          .toString(),
                      text: commentController.text,
                      postId: ZoneCubit
                          .get(context)
                          .postId[index]);
                }, icon: const Icon(IconlyBold.send, color: Colors.blue,)),
                IconButton(onPressed: () {
                  ZoneCubit.get(context).likePost(uid: ZoneCubit.get(context).userModel.uId,postId: ZoneCubit.get(context).postId[index],likes: ZoneCubit.get(context).likes);
                  },
                    icon: const Icon(
                      IconlyBroken.heart, size: 30, color: Colors.redAccent,)),
                const Text('Like', style: TextStyle(fontSize: 20),),
                const SizedBox(width: 15.0,),
                IconButton(onPressed: () {},
                    icon: const Icon(IconlyBroken.upload, size: 30,
                      color: Colors.orangeAccent,)),
                const Text('Share', style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
          if(ZoneCubit.get(context).comment.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildComment(context,ZoneCubit.get(context).comment[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 0,),
              itemCount: ZoneCubit.get(context).comment.length),
        ],
      ),
    );

Widget buildComment(context,CommentModel commentModel) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            foregroundImage: CachedNetworkImageProvider(
                commentModel.commentProfileImage),
            radius: 30,),
          const SizedBox(width: 20,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(commentModel.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  const SizedBox(height: 5,),
                  Text(commentModel.text,style: const TextStyle(fontSize: 18),maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: true,),
                ],
              ),
            ),
          ),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(IconlyBroken.heart))
        ],
      ),
    );
