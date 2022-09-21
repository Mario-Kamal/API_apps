import 'dart:io';

import 'package:api/component/component/component.dart';
import 'package:api/layout/zone_app/cubit/zone_cubit.dart';
import 'package:api/layout/zone_app/cubit/zone_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ZoneCubit, ZoneStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ZoneCubit.get(context).userModel;
        var profileImage = ZoneCubit.get(context).profileImage;
        var coverImage = ZoneCubit.get(context).coverImage;
        nameController.text = model.name;
        bioController.text = model.bio;
        phoneController.text = model.phone;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: TextButton(
                    onPressed: () {
                      ZoneCubit.get(context).updateUser(
                          name: nameController.text,
                          bio: bioController.text,
                          phone: phoneController.text);
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 380,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image(
                                image: coverImage == null
                                    ? CachedNetworkImageProvider(model.cover)
                                    : FileImage(coverImage),
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
                                        ZoneCubit.get(context)
                                            .getCoverImage(ImageSource.gallery);
                                      },
                                      icon: const Icon(
                                        IconlyBold.camera,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              foregroundImage: profileImage == null
                                  ? CachedNetworkImageProvider(model.profile)
                                  : FileImage(profileImage),
                              radius: 95,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey,
                                  child: IconButton(
                                    onPressed: () {
                                      ZoneCubit.get(context).getProfileImage(ImageSource.gallery);
                                    },
                                    icon: const Icon(
                                      IconlyBold.camera,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                if (profileImage != null || coverImage != null)
                  Row(
                    children: [
                      if (profileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(() {
                                ZoneCubit.get(context).uploudProfileImage(
                                    name: nameController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text);
                              }, 'Upload Profile', context),
                              if (state is ZoneUpdateUserLoadingState)
                                SizedBox(
                                  height: 10.0,
                                ),
                              if (state is ZoneUpdateUserLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if (coverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(() {
                                ZoneCubit.get(context).uploudCoverImage(
                                    name: nameController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text);
                              }, 'Upload Cover', context),
                              if (state is ZoneUpdateUserLoadingState)
                                SizedBox(
                                  height: 10.0,
                                ),
                              if (state is ZoneUpdateUserLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                    ],
                  ),
                const SizedBox(
                  height: 20.0,
                ),
                defaultTextFormField(
                  context,
                  isPassword: false,
                  controller: nameController,
                  type: TextInputType.name,
                  label: "Name",
                  prefix: IconlyBroken.profile,
                  validate: (String value) {
                    if (value.isEmpty) {
                      print("Please enter  your name");
                    }
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                defaultTextFormField(context,
                    isPassword: false,
                    controller: bioController,
                    type: TextInputType.text,
                    label: "Bio",
                    prefix: IconlyBroken.info_circle, validate: (String value) {
                  if (value.isEmpty) {
                    print("Please enter  your bio");
                  }
                }),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  context,
                  isPassword: false,
                  controller: phoneController,
                  type: TextInputType.phone,
                  label: "Phone",
                  prefix: IconlyBroken.call,
                  validate: (String value) {
                    if (value.isEmpty) {
                      print("Please enter  your Phone Number");
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<CroppedFile> cropCustomImage(File imageFile) async =>
    await ImageCropper().cropImage(
      aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
      sourcePath: imageFile.path,
      uiSettings: [androidUiSettings()],
    );

AndroidUiSettings androidUiSettings() => AndroidUiSettings(
      toolbarTitle: 'Crop Image',
      toolbarColor: Colors.red,
      toolbarWidgetColor: Colors.white,
      lockAspectRatio: false,
    );
