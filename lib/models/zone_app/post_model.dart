class PostModel {
  String name;
  String postProfileImage;
  String dateTime;
  String uId;
  String postImage;
  String text;
  List likes;

  PostModel({
    this.name,
    this.postProfileImage,
    this.dateTime,
    this.uId,
    this.postImage,
    this.text,
    this.likes
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postProfileImage = json['image'];
    dateTime = json['dateTime'];
    uId = json['uId'];
    postImage = json['postImage'];
    text = json['text'];
    likes = json[['likes']];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': postProfileImage,
      'dateTime': dateTime,
      'uId': uId,
      'postImage': postImage,
      'text': text,
      'likes': likes,
    };
  }
}
