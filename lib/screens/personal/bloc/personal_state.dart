part of 'personal_bloc.dart';

class PersonalState extends Equatable {
  const PersonalState();

  @override
  List<Object> get props => [];
}

class PersonalInitial extends PersonalState {}

class PersonalErrorState extends PersonalState {}

class PaymentLogData extends PersonalState {
  final List<PaymentLogModel> data;

  const PaymentLogData({required this.data});
}
