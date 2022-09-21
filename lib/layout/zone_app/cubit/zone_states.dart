abstract class ZoneStates {}

class ZoneInitialState extends ZoneStates {}

class ZoneGetUserLoadingState extends ZoneStates {}

class ZoneGetUserSuccessState extends ZoneStates {}

class ZoneGetUserErrorState extends ZoneStates {
  final String error;

  ZoneGetUserErrorState(this.error);
}


class ZoneChangeBottomNavState extends ZoneStates {}

class ZoneNewPostState extends ZoneStates {}

class ZoneGetProfileImageSuccessState extends ZoneStates {}

class ZoneUpdateProfileImageSuccessState extends ZoneStates {}

class ZoneUpdateProfileImageErrorState extends ZoneStates {}

class ZoneUpdateCoverImageSuccessState extends ZoneStates {}

class ZoneUpdateUserSuccessState extends ZoneStates {}

class ZoneUpdateUserLoadingState extends ZoneStates {}

class ZoneUpdateCoverImageErrorState extends ZoneStates {}

class ZoneGetProfileImageErrorState extends ZoneStates {}

class ZoneGetCoverImageSuccessState extends ZoneStates {}

class ZoneGetCoverImageErrorState extends ZoneStates {}

//create post
class ZoneCreatePostSuccessState extends ZoneStates {}

class ZoneCreatePostLoadingState extends ZoneStates {}

class ZoneCreatePostErrorState extends ZoneStates {}

class ZoneGetImagePostSuccessState extends ZoneStates {}

class ZoneGetImagePostErrorState extends ZoneStates {}

class ZoneRemoveImagePostSuccessState extends ZoneStates {}

class ZoneGetPostsLoadingState extends ZoneStates {}

class ZoneGetPostsSuccessState extends ZoneStates {}

class ZoneGetPostsErrorState extends ZoneStates {
  final String error;

  ZoneGetPostsErrorState(this.error);
}

class ZoneGetAllUsersLoadingState extends ZoneStates {}

class ZoneGetAllUsersSuccessState extends ZoneStates {}

class ZoneGetAllUsersErrorState extends ZoneStates {
  final String error;

  ZoneGetAllUsersErrorState(this.error);
}

class ZoneLikePostSuccessState extends ZoneStates {}

class ZoneLikePostErrorState extends ZoneStates {
  final String error;

  ZoneLikePostErrorState(this.error);
}
//comments
class ZoneGetCommentsLoadingState extends ZoneStates {}

class ZoneGetCommentsSuccessState extends ZoneStates {}

class ZoneGetCommentsErrorState extends ZoneStates {
  final String error;

  ZoneGetCommentsErrorState(this.error);
}
class ZoneCreateCommentSuccessState extends ZoneStates {}

class ZoneCreateCommentLoadingState extends ZoneStates {}

class ZoneCreateCommentErrorState extends ZoneStates {}

//chat

class ZoneGetMessageSuccessState extends ZoneStates {}

class ZoneGetMessageErrorState extends ZoneStates {}

class ZoneSendMessageSuccessState extends ZoneStates {}

class ZoneSendMessageErrorState extends ZoneStates {}