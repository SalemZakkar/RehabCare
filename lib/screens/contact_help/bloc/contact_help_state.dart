part of 'contact_help_bloc.dart';

abstract class ContactHelpState extends Equatable {
  const ContactHelpState();
}

class ContactHelpInitial extends ContactHelpState {
  @override
  List<Object> get props => [];
}

class ContactHelpSuccess extends ContactHelpState {
  final AboutApp aboutApp;

  const ContactHelpSuccess({required this.aboutApp});

  @override
  // TODO: implement props
  List<Object?> get props => [aboutApp];
}

class ContactHelpError extends ContactHelpState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
