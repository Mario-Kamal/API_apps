class ZoneUserModel {
  String name;
  String phone;
  String email;
  String uId;
  String profile;
  String cover;
  String bio;
  bool isEmailVerified;

  ZoneUserModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
    this.profile,
    this.cover,
    this.bio,
    this.isEmailVerified,
  });

  ZoneUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uId = json['uId'];
    profile = json['profile'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'profile': profile,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}
