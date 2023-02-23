part of 'medical_file_bloc.dart';

abstract class MedicalFileEvent extends Equatable {
  const MedicalFileEvent();
}

class MedicalGetEvent extends MedicalFileEvent {
  final String id;

  const MedicalGetEvent({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MedicalReset extends MedicalFileEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
