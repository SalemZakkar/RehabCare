import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rehab_care/screens/authentication/models/models_export.dart';
import 'package:rehab_care/screens/personal/model/payment_log_model.dart';
import 'package:rehab_care/screens/personal/personal_export.dart';
import 'package:rehab_care/web_services/web_services_export.dart';

part 'personal_event.dart';

part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc() : super(PersonalInitial()) {
    on<PersonalEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<PersonalChangeDataEvent>(_changeData);
    on<PaymentLogGet>(_paymentLogGet);
  }

  _changeData(
      PersonalChangeDataEvent event, Emitter<PersonalState> emit) async {}

  _paymentLogGet(PaymentLogGet event, Emitter<PersonalState> emit) async {
    emit(PersonalInitial());
    try {
      Response response = await myDio.post(EndPoints.historyPayment,
          queryParameters: {"user_id": event.id});
      if (response.statusCode == 200) {
        List raw = jsonDecode(response.data);
        List<PaymentLogModel> data = [];
        for (int i = 0; i < raw.length; i++) {
          data.add(PaymentLogModel.fromJson(raw[i]));
        }
        emit(PaymentLogData(data: data));
      } else {
        emit(const PaymentLogData(data: []));
      }
    } on DioError {
      emit(PersonalErrorState());
    } catch (e) {
      emit(const PaymentLogData(data: []));
    }
  }
}
