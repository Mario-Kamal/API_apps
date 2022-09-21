
abstract class ZoneRegisterState {}
class ZoneRegisterInitialState extends ZoneRegisterState{}

class ZoneRegisterSuccessState extends ZoneRegisterState{}

class ZoneRegisterLoadingState extends ZoneRegisterState{}

class ZoneRegisterErrorState extends ZoneRegisterState{
  final String error;

  ZoneRegisterErrorState(this.error);
}class ZoneUserCreateSuccessState extends ZoneRegisterState{}

class ZoneUserCreateLoadingState extends ZoneRegisterState{}

class ZoneUserCreateErrorState extends ZoneRegisterState{
  final String error;

  ZoneUserCreateErrorState(this.error);
}
class ZoneRegisterChangePasswordVisibilityState extends ZoneRegisterState{}