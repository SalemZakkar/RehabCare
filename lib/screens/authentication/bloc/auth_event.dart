part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthInitialEven extends AuthEvent {}

class AuthSignInEven extends AuthEvent {
  final String phoneNumber;
  String? userEmailEvent;
  final String passwordEvent;
  final String displayName;
  final String tokenFCM;
  final bool isSignIn;
  final bool autoSignIn;

  AuthSignInEven({
    required this.phoneNumber,
    this.userEmailEvent,
    required this.passwordEvent,
    required this.displayName,
    required this.tokenFCM,
    required this.isSignIn,
    required this.autoSignIn,
  });
}

class AuthSignOutEven extends AuthEvent {}

class AuthGetPrefUserInfoEvent extends AuthEvent {}

class AuthErrorEvent extends AuthEvent {}

class AuthForGetPasswordEvent extends AuthEvent {
  final MyUserInfo myUserInfo;

  AuthForGetPasswordEvent(this.myUserInfo);
}

class AuthChangePasswordEvent extends AuthEvent {
  final String newPassword;

  AuthChangePasswordEvent(this.newPassword);
}

class AuthUpdateUserInfoEvent extends AuthEvent {
  final MyUserInfo myUserInfo;

  AuthUpdateUserInfoEvent(this.myUserInfo);
}

class AboutGetEvent extends AuthEvent {}
