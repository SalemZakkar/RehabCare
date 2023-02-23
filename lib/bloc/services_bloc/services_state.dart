part of 'services_bloc.dart';

abstract class ServicesState extends Equatable {
  final bool isDark;
  final bool languageIsEnglish;
  final DrawerInfo drawerInfo;

  const ServicesState({
    required this.isDark,
    required this.languageIsEnglish,
    required this.drawerInfo,
  });

  @override
  List<Object> get props => [isDark, languageIsEnglish];
}

class ServicesInitialState extends ServicesState {
  const ServicesInitialState(
      {required super.isDark,
      required super.languageIsEnglish,
      required super.drawerInfo});
}

class ChangeThemeModeState extends ServicesState {
  const ChangeThemeModeState(
      {required super.isDark,
      required super.languageIsEnglish,
      required super.drawerInfo});
}

class ChangeLanguageState extends ServicesState {
  const ChangeLanguageState(
      {required super.isDark,
      required super.languageIsEnglish,
      required super.drawerInfo});
}

class GetServicesState extends ServicesState {
  const GetServicesState(
      {required super.isDark,
      required super.languageIsEnglish,
      required super.drawerInfo});
}

class DrawerGetInfoState extends ServicesState {
  const DrawerGetInfoState(
      {required super.isDark,
      required super.languageIsEnglish,
      required super.drawerInfo});
}

class FeedBackDone extends ServicesState {
  const FeedBackDone(
      {required super.isDark,
      required super.languageIsEnglish,
      required super.drawerInfo});
}

class FeedBackError extends ServicesState {
  const FeedBackError(
      {required super.isDark,
      required super.languageIsEnglish,
      required super.drawerInfo});
}

class FeedBackWaiting extends ServicesState {
  const FeedBackWaiting(
      {required super.isDark,
      required super.languageIsEnglish,
      required super.drawerInfo});
}
