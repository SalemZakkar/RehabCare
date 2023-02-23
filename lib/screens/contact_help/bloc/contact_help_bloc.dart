import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rehab_care/screens/authentication/models/models_export.dart';
import 'package:rehab_care/web_services/web_services_export.dart';

import '../../../bloc/bloc_export.dart';

part 'contact_help_event.dart';

part 'contact_help_state.dart';

class ContactHelpBloc extends Bloc<ContactHelpEvent, ContactHelpState> {
  ContactHelpBloc() : super(ContactHelpInitial()) {
    on<ContactHelpEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetHelpCenterInfoEvent>(getAboutData);
  }

  void getAboutData(
      GetHelpCenterInfoEvent event, Emitter<ContactHelpState> emitter) async {
    emitter(ContactHelpInitial());
    try {
      Response response = await myDio.post(EndPoints.about);
      if (response.statusCode == 200) {
        emitter(ContactHelpSuccess(
            aboutApp: AboutApp.fromJson(jsonDecode(response.data.toString()))));
      }
    } catch (e) {
      emitter(ContactHelpError());
    }
  }
}
