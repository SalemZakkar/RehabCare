part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final MyUserLogin myUserLogin;
  final MyUserInfo myUserInfo;
  final AboutApp aboutApp;

  const AuthState({
    required this.myUserLogin,
    required this.myUserInfo,
    required this.aboutApp,
  });

  @override
  List<Object> get props => [myUserLogin, myUserInfo, aboutApp];
}

class AuthInitialState extends AuthState {
  AuthInitialState()
      : super(
          myUserLogin: MyUserLogin(),
          myUserInfo: MyUserInfo(),
          aboutApp: AboutApp(),
        );
}

class AuthSignInState extends AuthState {
  const AuthSignInState({
    required MyUserLogin myUserLogin,
    required MyUserInfo myUserInfo,
    required AboutApp aboutApp,
  }) : super(
          myUserLogin: myUserLogin,
          myUserInfo: myUserInfo,
          aboutApp: aboutApp,
        );
}

class AuthSignOutState extends AuthState {
  AuthSignOutState()
      : super(
          myUserLogin: MyUserLogin(id: null, data: null),
          myUserInfo: MyUserInfo(),
          aboutApp: AboutApp(),
        );
}

class AuthGetPrefUserInfoState extends AuthState {
  AuthGetPrefUserInfoState({required MyUserInfo myUserInfo})
      : super(
          myUserLogin: MyUserLogin(),
          myUserInfo: myUserInfo,
          aboutApp: AboutApp(),
        );
}

class AuthErrorLogInState extends AuthState {
  final String errorTitle;
  final String errorBody;

  AuthErrorLogInState({
    required this.errorTitle,
    required this.errorBody,
  }) : super(
          myUserLogin: MyUserLogin(),
          myUserInfo: MyUserInfo(),
          aboutApp: AboutApp(),
        );
}

class AuthUpdateUserInfoState extends AuthState {
  const AuthUpdateUserInfoState({
    required super.myUserLogin,
    required super.myUserInfo,
    required super.aboutApp,
  });
}

class AuthChangePasswordState extends AuthState {
  const AuthChangePasswordState(
      {required super.myUserLogin,
      required super.myUserInfo,
      required super.aboutApp});
}

class AboutGetState extends AuthState {
  const AboutGetState(
      {required super.myUserLogin,
      required super.myUserInfo,
      required super.aboutApp});
}

class AuthChangePasswordErrorState extends AuthState {
  const AuthChangePasswordErrorState(
      {required super.myUserLogin,
      required super.myUserInfo,
      required super.aboutApp});
}

class AuthChangeInfoErrorState extends AuthState {
  const AuthChangeInfoErrorState(
      {required super.myUserLogin,
      required super.myUserInfo,
      required super.aboutApp});
}

class AuthWaitingState extends AuthState {
  const AuthWaitingState(
      {required super.myUserLogin,
      required super.myUserInfo,
      required super.aboutApp});
}

class AuthErrorState extends AuthState {
  const AuthErrorState(
      {required super.myUserLogin,
      required super.myUserInfo,
      required super.aboutApp});
}
