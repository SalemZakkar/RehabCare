import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rehab_care/screens/medical_file/medical_file_export.dart';
import 'package:rehab_care/screens/medical_file/models/medical_file.dart';
import 'package:rehab_care/web_services/web_services_export.dart';

part 'medical_file_event.dart';

part 'medical_file_state.dart';

class MedicalFileBloc extends Bloc<MedicalFileEvent, MedicalFileState> {
  MedicalFileBloc() : super(MedicalFileInitial()) {
    on<MedicalFileEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<MedicalGetEvent>(_medicalFileGet);
    on<MedicalReset>(_medicalReset);
  }

  _medicalFileGet(MedicalGetEvent event, Emitter<MedicalFileState> emit) async {
    emit(MedicalWait());
    try {
      Response response = await myDio.post(EndPoints.medicalReport,
          queryParameters: {"child_id": event.id});
      if (response.statusCode == 200) {
        List data = jsonDecode(response.data);
        emit(MedicalFileGetState(medicalFile: MedicalFile.fromJson(data[0])));
      } else {
        emit(MedicalEmpty());
      }
    } on DioError {
      emit(MedicalFail());
    } catch (e) {
      emit(MedicalEmpty());
    }
  }

  _medicalReset(MedicalReset event, Emitter<MedicalFileState> emit) {
    emit(MedicalFileInitial());
  }
}
