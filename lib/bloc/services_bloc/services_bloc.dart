import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config_export.dart';
import '../../screens/authentication/models/models_export.dart';
import '../../web_services/web_services_export.dart';
import '../bloc_export.dart';
import '../model/model_export.dart';

part 'services_event.dart';

part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc()
      : super(ServicesInitialState(
            isDark: false, languageIsEnglish: true, drawerInfo: DrawerInfo())) {
    Future<void> initService(var event, var emit, var startTime) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        bool? isDark = prefs.getBool("isDark");
        bool? languageIsEnglish = prefs.getBool("languageIsEnglish");

        isDark ??= false;
        languageIsEnglish ??= true;

        printLog("get Services isDark and languageIsEnglish", startTime);
        // bool language = state.languageIsEnglish == true ? false : true;

        if (languageIsEnglish == true) {
          appLanguage = AppLanguage.englishLanguage;
        } else {
          appLanguage = AppLanguage.arabicLanguage;
        }
        emit(GetServicesState(
            isDark: isDark,
            languageIsEnglish: languageIsEnglish,
            drawerInfo: DrawerInfo()));
      } catch (error) {
        rethrow;
      }
    }

    on<GetServicesPrefEvent>((event, emit) async {
      DateTime startTime = DateTime.now();
      await initService(event, emit, startTime);
    });

    on<ChangeModeThemeEvent>((event, emit) {
      bool mood = state.isDark == true ? false : true;

      ///don't delete
      ThemeManage.setTheme(event.theme);
      emit(ChangeThemeModeState(
        isDark: mood,
        languageIsEnglish: state.languageIsEnglish,
        drawerInfo: DrawerInfo(),
      ));
    });

    on<ChangeLanguageEvent>((event, emit) {
      bool language = state.languageIsEnglish == true ? false : true;
      if (language == true) {
        appLanguage = AppLanguage.englishLanguage;
      } else {
        appLanguage = AppLanguage.arabicLanguage;
      }

      ///don't delete
      LanguageManager.setLang(event.language);
      emit(ChangeLanguageState(
        isDark: state.isDark,
        languageIsEnglish: language,
        drawerInfo: DrawerInfo(),
      ));
    });
    on<ServicesEvent>(_servicesEvent);
    on<SendFeedBackEvent>(_sendFeedBackEvent);
    on<DrawerGetInfoEvent>(_drawerGetInfoEvent);
  }

  _servicesEvent(ServicesEvent event, Emitter<ServicesState> emit) async {}

  _sendFeedBackEvent(
      SendFeedBackEvent event, Emitter<ServicesState> emit) async {
    emit(FeedBackWaiting(
        isDark: state.isDark,
        languageIsEnglish: state.languageIsEnglish,
        drawerInfo: state.drawerInfo));
    try {
      Response resSendFeedBack =
          await myDio.post(EndPoints.feedBackAPI, queryParameters: {
        'name': event.name,
        'email': event.email,
        'phone': event.phone,
        'massage': event.message,
      });

      if (resSendFeedBack.statusCode == 200) {
        emit(FeedBackDone(
            isDark: state.isDark,
            languageIsEnglish: state.languageIsEnglish,
            drawerInfo: state.drawerInfo));
      } else {
        emit(FeedBackError(
            isDark: state.isDark,
            languageIsEnglish: state.languageIsEnglish,
            drawerInfo: state.drawerInfo));
      }
    } catch (error) {
      emit(FeedBackError(
          isDark: state.isDark,
          languageIsEnglish: state.languageIsEnglish,
          drawerInfo: state.drawerInfo));
      printLog(error.toString());
    }
  }

  _drawerGetInfoEvent(
      DrawerGetInfoEvent event, Emitter<ServicesState> emit) async {
    try {
      Response resGetDrawerInfo = await myDio.post(
        EndPoints.drawerInfo,
        queryParameters: {
          "user_id": event.myUserInfo.userId,
        },
      );

      if (resGetDrawerInfo.statusCode == 200) {
        List<dynamic> list = jsonDecode(resGetDrawerInfo.data);
        DrawerInfo drawerInfo = DrawerInfo();

        for (var element in list) {
          drawerInfo = DrawerInfo.fromJson(element);
        }

        emit(DrawerGetInfoState(
          isDark: state.isDark,
          languageIsEnglish: state.languageIsEnglish,
          drawerInfo: drawerInfo,
        ));
      }
    } catch (error) {
      printLog(error.toString());
    }
  }
}
