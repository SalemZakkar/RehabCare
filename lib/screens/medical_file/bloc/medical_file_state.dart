part of 'medical_file_bloc.dart';

class MedicalFileState extends Equatable {
  const MedicalFileState();

  @override
  List<Object> get props => [];
}

class MedicalFileInitial extends MedicalFileState {}

class MedicalFileGetState extends MedicalFileState {
  final MedicalFile medicalFile;

  const MedicalFileGetState({required this.medicalFile});
}

class MedicalFail extends MedicalFileState {}

class MedicalWait extends MedicalFileState {}

class MedicalEmpty extends MedicalFileState {}
