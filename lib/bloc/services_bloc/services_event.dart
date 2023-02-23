part of 'services_bloc.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangeModeThemeEvent extends ServicesEvent {
  final int theme;

  const ChangeModeThemeEvent({required this.theme});
}

class ChangeLanguageEvent extends ServicesEvent {
  final String language;

  const ChangeLanguageEvent({required this.language});
}

class GetServicesPrefEvent extends ServicesEvent {}

class SendFeedBackEvent extends ServicesEvent {
  final String name;
  final String email;
  final String phone;
  final String message;

  const SendFeedBackEvent(
      {required this.name,
      required this.email,
      required this.phone,
      required this.message});
}

class DrawerGetInfoEvent extends ServicesEvent {
  final MyUserInfo myUserInfo;

  const DrawerGetInfoEvent(this.myUserInfo);
}
