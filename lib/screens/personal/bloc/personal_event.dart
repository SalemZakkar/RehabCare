part of 'personal_bloc.dart';

abstract class PersonalEvent extends Equatable {
  const PersonalEvent();
}

class PersonalChangeDataEvent extends PersonalEvent {
  final MyUserInfo myUserInfo;

  const PersonalChangeDataEvent({required this.myUserInfo});

  @override
  List<Object?> get props => [];
}

class PersonalError extends PersonalEvent {
  @override
  List<Object?> get props => [];
}

class PaymentLogGet extends PersonalEvent {
  final String id;

  @override
  // TODO: implement props
  List<Object?> get props => [];

  const PaymentLogGet({required this.id});
}
