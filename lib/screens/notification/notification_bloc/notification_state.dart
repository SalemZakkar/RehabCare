part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<Notifications> data;

  NotificationSuccess({required this.data});
}

class NotificationError extends NotificationState {}
