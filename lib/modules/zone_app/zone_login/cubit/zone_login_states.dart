abstract class ZoneLoginState {}
class ZoneLoginInitialState extends ZoneLoginState{}

class ZoneLoginSuccessState extends ZoneLoginState{
  final String uId;

  ZoneLoginSuccessState(this.uId);
}

class ZoneLoginLoadingState extends ZoneLoginState{}

class ZoneLoginErrorState extends ZoneLoginState{
  final String error;

  ZoneLoginErrorState(this.error);
}
class ZoneChangePasswordVisibilityState extends ZoneLoginState{}
