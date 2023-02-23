import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:rehab_care/screens/authentication/models/models_export.dart';
import 'package:rehab_care/screens/notification/notification_export.dart';
import 'package:rehab_care/web_services/web_services_export.dart';

import '../models/notifications.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<GetNotificationsEvent>(_getNotification);
  }

  _getNotification(
      GetNotificationsEvent event, Emitter<NotificationState> emit) async {
    debugPrint("Get Notification Data \n-----------------------------");
    emit(NotificationInitial());
    try {
      Response response = await myDio.post(EndPoints.notifications,
          queryParameters: {"user_id": event.myUserInfo.userId});
      if (response.statusCode == 200) {
        List data = jsonDecode(response.data);
        List<Notifications> notifications = [];
        for (int i = 0; i < data.length; i++) {
          notifications.add(Notifications.fromJson(data[i]));
        }
        emit(NotificationSuccess(data: notifications));
      } else {
        emit(NotificationError());
      }
    } on DioError {
      emit(NotificationError());
    } catch (e) {
      emit(NotificationSuccess(data: const []));
    }
  }
}
