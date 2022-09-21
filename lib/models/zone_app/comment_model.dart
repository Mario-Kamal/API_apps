class CommentModel {
  String name;
  String commentProfileImage;
  String dateTime;
  String uId;
  String text;

  CommentModel({
    this.name,
    this.commentProfileImage,
    this.dateTime,
    this.uId,
    this.text,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    commentProfileImage = json['image'];
    dateTime = json['dateTime'];
    uId = json['uId'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': commentProfileImage,
      'dateTime': dateTime,
      'uId': uId,
      'text': text,
    };
  }
}
