import 'dart:io';

import 'package:api/component/component/component.dart';
import 'package:api/layout/zone_app/cubit/zone_states.dart';
import 'package:api/models/zone_app/comment_model.dart';
import 'package:api/models/zone_app/message_model.dart';
import 'package:api/models/zone_app/post_model.dart';
import 'package:api/models/zone_app/zone_user_model.dart';
import 'package:api/modules/zone_app/home/zone_home_screen.dart';
import 'package:api/modules/zone_app/post/add_post_screen.dart';
import 'package:api/modules/zone_app/profile/zone_profile_screen.dart';
import 'package:api/modules/zone_app/setting/zone_setting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../modules/zone_app/search/zone_search_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ZoneCubit extends Cubit<ZoneStates> {
  ZoneCubit() : super(ZoneInitialState());

  static ZoneCubit get(context) => BlocProvider.of(context);
  ZoneUserModel userModel;

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const SettingScreen(),
    const ProfileScreen(),
  ];
  List<Widget> title = [
    Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            foregroundImage: NetworkImage(
                "https://img.freepik.com/free-vector/gangster-skull-vector-illustration-head-skeleton-hat-with-cigar-mouth-criminal-mafia-concept-gang-emblems-tattoo-templates_74855-12236.jpg?size=338&ext=jpg&ga=GA1.2.2045067912.1642375139"),
            radius: 28,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Mario Kamal",
              style: TextStyle(fontSize: 25),
            ),
            Text(
              "See your profile",
              style: TextStyle(fontSize: 18, color: Colors.white38),
            ),
          ],
        )
      ],
    ),
    const Text('Search'),
    const Text("Create Post"),
    const Text('Setting'),
    const Text('Profile'),
  ];

  void changeBottom(int index) {
    if (index == 2) {
      emit(ZoneNewPostState());
    } else {
      currentIndex = index;
      emit(ZoneChangeBottomNavState());
    }
  }

  void getUserData() {
    emit(ZoneGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = ZoneUserModel.fromJson(value.data());
      emit(ZoneGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ZoneGetUserErrorState(error.toString()));
    });
  }

  // Future getProfileImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     profileImage = File(pickedFile.path);
  //     emit(ZoneGetProfileImageSuccessState());
  //   } else {
  //     print("No Image Selected");
  //     emit(ZoneGetProfileImageErrorState());
  //   }
  // }
  File profileImage;
  var picker = ImagePicker();

  Future getProfileImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      final cropped = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
          ],
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
                toolbarColor: Colors.deepOrange,
                toolbarTitle: "RPS Cropper",
                statusBarColor: Colors.deepOrange.shade900,
                backgroundColor: Colors.white,
                lockAspectRatio: false)
          ]);
      profileImage = File(cropped.path);
      emit(ZoneGetProfileImageSuccessState());
    } else {
      print("No Image Selected");
      emit(ZoneGetProfileImageErrorState());
    }
  }

  File coverImage;

  Future getCoverImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      final cropped = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
          compressQuality: 100,
          maxWidth: 1500,
          maxHeight: 400,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
                toolbarColor: Colors.deepOrange,
                toolbarTitle: "RPS Cropper",
                statusBarColor: Colors.deepOrange.shade900,
                backgroundColor: Colors.white,
                lockAspectRatio: false)
          ]);
      coverImage = File(cropped.path);
      emit(ZoneGetCoverImageSuccessState());
    } else {
      print("No Image Selected");
      emit(ZoneGetCoverImageErrorState());
    }
  }

  var profileImageUrl;

  void uploudProfileImage({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(ZoneUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage.path).pathSegments.last}")
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(ZoneUpdateProfileImageSuccessState());
        updateUser(name: name, bio: bio, phone: phone, profile: value);
      }).catchError((error) {
        emit(ZoneUpdateProfileImageErrorState());
      });
    }).catchError((error) {});
  }

  void uploudCoverImage({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(ZoneUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage.path).pathSegments.last}")
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(ZoneUpdateCoverImageSuccessState());
        updateUser(name: name, bio: bio, phone: phone, cover: value);
      }).catchError((error) {
        emit(ZoneUpdateCoverImageErrorState());
      });
    }).catchError((error) {});
  }

  void updateUser({
    @required String name,
    @required String bio,
    @required String phone,
    String cover,
    String profile,
  }) {
    ZoneUserModel model = ZoneUserModel(
      name: name,
      phone: phone,
      email: userModel.email,
      uId: userModel.uId,
      isEmailVerified: false,
      bio: bio,
      profile: profile ?? userModel.profile,
      cover: cover ?? userModel.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {});
  }

  File postImage;

  Future getPostImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      postImage = File(image.path);
      emit(ZoneGetImagePostSuccessState());
    } else {
      print("No Image Selected");
      emit(ZoneGetCoverImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(ZoneRemoveImagePostSuccessState());
  }

  void uploudPost({
    @required String dateTime,
    @required String text,
  }) {
    emit(ZoneCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage.path).pathSegments.last}")
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(ZoneCreatePostErrorState());
      });
    }).catchError((error) {
      emit(ZoneCreatePostErrorState());
    });
  }

  PostModel postModel;

  void createPost(
      {@required String dateTime, @required String text, String postImage}) {
    emit(ZoneCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel.name,
      uId: userModel.uId,
      postProfileImage: userModel.profile,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(ZoneCreatePostSuccessState());
    }).catchError((error) {
      emit(ZoneCreatePostSuccessState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<String> commentId = [];
  List<String> likes = [];
  List<int> comments = [];

  void getPosts() {
    emit(ZoneGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      posts = [];
      for (var element in event.docs) {
        // likes.add(element.get('likes'));
        postId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
      }
    });
  }

  List<CommentModel> comment = [];

  void getComments() {
    emit(ZoneGetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        element.reference
            .collection('comments')
            .orderBy('dateTime')
            .snapshots()
            .listen((event) {
          comment = [];
          for (var element in event.docs) {
            comments.add(event.docs.length);
            commentId.add(element.id);
            comment.add(CommentModel.fromJson(element.data()));
          }
        });
      }
    });
  }
  void likePost({String postId, String uid, List likes}) async {
    try {
      if (likes.contains(uid)) {
        FirebaseFirestore.instance.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        FirebaseFirestore.instance.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {}
  }

  CommentModel commentModel;

  void createComment(
      {@required String dateTime, @required String text, String postId}) {
    emit(ZoneCreateCommentLoadingState());
    CommentModel model = CommentModel(
      name: userModel.name,
      uId: userModel.uId,
      dateTime: dateTime,
      commentProfileImage: userModel.profile,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      emit(ZoneCreateCommentSuccessState());
    }).catchError((error) {
      emit(ZoneCreateCommentErrorState());
    });
  }

  List<ZoneUserModel> users = [];

  void getAllUsers() {
    emit(ZoneGetAllUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel.uId) {
            users.add(ZoneUserModel.fromJson(element.data()));
          }
        }
      }).then((value) {
        emit(ZoneGetAllUsersSuccessState());
      }).catchError((error) {
        emit(ZoneGetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    @required String receiverId,
    @required String dateTime,
    @required String text,
  }) {
    MessageModel model = MessageModel(
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
      senderId: userModel.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ZoneSendMessageSuccessState());
    }).catchError((error) {
      emit(ZoneSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ZoneSendMessageSuccessState());
    }).catchError((error) {
      emit(ZoneSendMessageErrorState());
    });
  }

  List<MessageModel> message = [];

  void getMessage({@required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      message = [];
      for (var element in event.docs) {
        message.add(MessageModel.fromJson(element.data()));
      }
      emit(ZoneGetMessageSuccessState());
    });
  }

  void likeComment({
    @required String postId,
    @required String commentId,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .set({
      'likes': [uId]
    });
  }
}
