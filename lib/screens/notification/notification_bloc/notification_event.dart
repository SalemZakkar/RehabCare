part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class GetNotificationsEvent extends NotificationEvent {
  final MyUserInfo myUserInfo;

  GetNotificationsEvent({required this.myUserInfo});
}
