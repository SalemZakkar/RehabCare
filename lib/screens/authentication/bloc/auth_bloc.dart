import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/config_export.dart';
import '../../../web_services/web_services_export.dart';
import '../authentication_export.dart';
import '../models/models_export.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthSignInEven>(_authSignInEvent);
    on<AuthSignOutEven>(_authSignOutEven);
    on<AuthGetPrefUserInfoEvent>(_authGetPrefUserInfoEvent);
    on<AuthForGetPasswordEvent>(_authForGetPasswordEvent);
    on<AuthChangePasswordEvent>(_authChangePasswordEvent);
    on<AuthUpdateUserInfoEvent>(_authUpdateUserInfoEvent);
    on<AboutGetEvent>(_aboutGetEvent);
  }

  _authSignInEvent(AuthSignInEven event, Emitter<AuthState> emit) async {
    DateTime startTime = DateTime.now();
    if (event.isSignIn == true) {
      try {
        Response resLogIn = await myDio.post(
          EndPoints.logIn,
          queryParameters: {
            'phone': event.phoneNumber,
            'password': event.passwordEvent,
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );

        if (resLogIn.statusCode == 200) {
          MyUserLogin myUserLogin =
              MyUserLogin.fromJson(jsonDecode(resLogIn.data));

          if (myUserLogin.id != "0") {
            if (event.autoSignIn == false) {
              final resUpdateToken = await myDio.post(
                EndPoints.updateToken,
                queryParameters: {
                  "user_id": myUserLogin.data.toString(),
                  "token": event.tokenFCM,
                },
              );
              if (resUpdateToken.statusCode == 200) {
                debugPrint('done update token');
              } else {
                debugPrint("error update token/**/");
              }
            }

            Response resUserInfo = await myDio.post(
              EndPoints.userInfo,
              queryParameters: {
                'user_id': myUserLogin.data.toString(),
              },
              options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                },
              ),
            );
            List<dynamic> listResUserInfo = jsonDecode(resUserInfo.data);
            MyUserInfo myUserInfo = MyUserInfo();
            for (var element in listResUserInfo) {
              myUserInfo = MyUserInfo.fromJson(((element)));
            }

            myUserInfo = myUserInfo.copyWith(password: event.passwordEvent);

            /// Save local data
            _setPrefUserInfo(
              phoneNumber: event.phoneNumber,
              userPassword: event.passwordEvent,
            );

            ///Emit BlocState
            emit(AuthSignInState(
              myUserLogin: myUserLogin,
              myUserInfo: myUserInfo,
              aboutApp: AboutApp(),
            ));
          } else {
            emit(AuthErrorLogInState(
                errorTitle: "errorTitle", errorBody: S().errorAuth));
          }
        }
        printLog('done SingIn', startTime);
      } on DioError catch (error) {
        emit(AuthErrorLogInState(
            errorTitle: 'Error SignIn', errorBody: S().network_error));

        // / <<<<< IN THIS LINE
        // if (error.response!.statusCode == 404) {
        //   print(error.response!.statusCode);
        // } else {
        //   print(error.message);
        //   // print(error.response);

        printLog("===> error Iam here AuthSignIn$error");
        // }
      }
    } else {
      ///SignUp Method
      try {
        final resRegister = await myDio.post(EndPoints.register,
            queryParameters: {
              'name': event.displayName,
              'phone': event.phoneNumber,
              'email': event.userEmailEvent,
              'city': "city",
              'password': event.passwordEvent,
            },
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              },
            ));

        if (resRegister.statusCode == 200) {
          Response resLogIn = await myDio.post(
            EndPoints.logIn,
            queryParameters: {
              'phone': event.phoneNumber,
              'password': event.passwordEvent,
            },
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              },
            ),
          );

          MyUserLogin myUserLogin =
              MyUserLogin.fromJson(jsonDecode(resLogIn.data));

          if (event.autoSignIn == false) {
            final resUpdateToken = await myDio.post(
              EndPoints.updateToken,
              queryParameters: {
                "user_id": myUserLogin.data.toString(),
                "token": event.tokenFCM,
              },
            );
            if (resUpdateToken.statusCode == 200) {
              debugPrint('done update token');
            } else {
              debugPrint("error update token/**/");
            }
          }

          Response resUserInfo = await myDio.post(
            EndPoints.userInfo,
            queryParameters: {
              'user_id': myUserLogin.data.toString(),
            },
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              },
            ),
          );
          List<dynamic> listResUserInfo = jsonDecode(resUserInfo.data);
          MyUserInfo myUserInfo = MyUserInfo();
          for (var element in listResUserInfo) {
            myUserInfo = MyUserInfo.fromJson(((element)));
          }

          myUserInfo = myUserInfo.copyWith(password: event.passwordEvent);

          final resUpdateToken = await myDio.post(
            EndPoints.updateToken,
            queryParameters: {
              "user_id": myUserLogin.data.toString(),
              "token": event.tokenFCM,
            },
          );
          if (resUpdateToken.statusCode == 200) {
            printLog('done update token');
          } else {
            printLog("error update token/**/");
          }

          /// Save local data
          await _setPrefUserInfo(
            phoneNumber: event.phoneNumber,
            userPassword: event.passwordEvent,
          );

          ///Emit BlocState
          emit(AuthSignInState(
            myUserLogin: myUserLogin,
            myUserInfo: myUserInfo,
            aboutApp: AboutApp(),
          ));
        }
      } catch (error) {
        printLog("===> error Iam here AuthSingUp$error");
      }
    }
  }

  _authSignOutEven(AuthSignOutEven event, Emitter<AuthState> emit) async {
    DateTime startTime = DateTime.now();
    try {
      await FirebaseAuth.instance.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("password");
      await prefs.remove("phoneNumber");
      printLog("Sign Out", startTime);
      emit(AuthSignOutState());
    } on FirebaseAuthException catch (error) {
      emit(AuthErrorLogInState(
          errorTitle: 'Error SignOut',
          errorBody: getMyAuthError(
            error.code.toString(),
            error.message.toString(),
          )));
    }
  }

  _authGetPrefUserInfoEvent(
      AuthGetPrefUserInfoEvent event, Emitter<AuthState> emit) async {
    DateTime startTime = DateTime.now();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userPhoneNumber = prefs.getString("phoneNumber");
    String? userPassword = prefs.getString("password");

    try {
      emit(AuthGetPrefUserInfoState(
          myUserInfo:
              MyUserInfo(phone: userPhoneNumber, password: userPassword)));
      printLog("Auth Get Pref User Info Event", startTime);
    } catch (error) {
      rethrow;
    }
  }

  _authForGetPasswordEvent(
      AuthForGetPasswordEvent event, Emitter<AuthState> emit) async {
    try {
      final resForGetPassword = await myDio.get(EndPoints.forgetPassword,
          queryParameters: {
            'phone': event.myUserInfo.phone,
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ));
      if (resForGetPassword.statusCode == 200) {
        var ch = jsonDecode(resForGetPassword.toString());
        if (ch['status'].toString() == "0") {
          emit(AuthErrorLogInState(
              errorTitle: "", errorBody: "الرقم غير مسجل لدينا"));
          printLog(
              "=====> I'm hare resForGetPassword state is 0 : ${ch['status']}");
        } else {
          emit(AuthErrorLogInState(
              errorTitle: "", errorBody: "تم إرسال الرسالة"));
          printLog(
              "=====> I'm hare resForGetPassword state is 1 : ${ch['status']}");
        }
      } else {
        printLog('=====> error resForGetPassword');
      }
      printLog(resForGetPassword.data);
    } catch (error) {
      printLog(error);
    }
  }

  _authChangePasswordEvent(
      AuthChangePasswordEvent event, Emitter<AuthState> emit) async {
    MyUserInfo myUserInfo = state.myUserInfo;
    try {
      Response resChangePassword = await myDio.post(
        EndPoints.checkPasswordProfile,
        queryParameters: {
          "user_id": myUserInfo.userId,
          "password": myUserInfo.password,
          "new_password": event.newPassword,
        },
      );
      if (resChangePassword.statusCode == 200) {
        myUserInfo = myUserInfo.copyWith(password: event.newPassword);
        debugPrint("=========>");
        debugPrint(myUserInfo.password.toString());
        await _setPrefUserInfo(
            phoneNumber: myUserInfo.phone.toString(),
            userPassword: event.newPassword.toString());

        emit(AuthChangePasswordState(
          myUserLogin: state.myUserLogin,
          myUserInfo: myUserInfo,
          aboutApp: AboutApp(),
        ));
      } else {
        emit(AuthErrorState(
            myUserLogin: state.myUserLogin,
            myUserInfo: myUserInfo,
            aboutApp: AboutApp()));
      }
    } catch (error) {
      emit(AuthErrorState(
          myUserLogin: state.myUserLogin,
          myUserInfo: myUserInfo,
          aboutApp: AboutApp()));

      printLog(error);
    }
  }

  _authUpdateUserInfoEvent(
      AuthUpdateUserInfoEvent event, Emitter<AuthState> emit) async {
    //emit(AuthWaitingState(myUserLogin: MyUserLogin(), myUserInfo: MyUserInfo(), aboutApp: AboutApp()));
    try {
      final resUpdateUserInfo = await myDio.post(
        EndPoints.updateUser,
        queryParameters: {
          "user_id": state.myUserLogin.data,
          "name": event.myUserInfo.name,
          "email": event.myUserInfo.email,
        },
      );
      if (resUpdateUserInfo.statusCode == 200) {
        emit(AuthUpdateUserInfoState(
          myUserLogin: state.myUserLogin,
          myUserInfo: state.myUserInfo.copyWith(
            name: event.myUserInfo.name,
            email: event.myUserInfo.email,
          ),
          aboutApp: AboutApp(),
        ));
      } else {
        emit(AuthErrorState(
            myUserLogin: MyUserLogin(),
            myUserInfo: event.myUserInfo,
            aboutApp: AboutApp()));
      }
    } catch (error) {
      emit(AuthErrorState(
          myUserLogin: MyUserLogin(),
          myUserInfo: event.myUserInfo,
          aboutApp: AboutApp()));
      printLog(error);
    }
  }

  _aboutGetEvent(AboutGetEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitialState());
    try {
      Response resGetAbout = await myDio.post(EndPoints.about);

      if (resGetAbout.statusCode == 200) {
        AboutApp aboutApp =
            AboutApp.fromJson(jsonDecode(resGetAbout.data.toString()));

        emit(AuthSignInState(
          myUserLogin: state.myUserLogin,
          myUserInfo: state.myUserInfo,
          aboutApp: aboutApp,
        ));
      } else {}
    } catch (error) {
      printLog("error about get event$error");
    }
  }

  _setPrefUserInfo({
    required String phoneNumber,
    required String userPassword,
  }) async {
    DateTime startTime = DateTime.now();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("phoneNumber", phoneNumber);
      await prefs.setString("password", userPassword);

      printLog("Auth Set Pref User Info Event", startTime);
    } catch (error) {
      rethrow;
    }
  }
}
