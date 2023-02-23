import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:rehab_care/config/config_export.dart';
import 'package:rehab_care/screens/home/model/model_export.dart';
import 'package:rehab_care/screens/home/model/teatment_plan_data.dart';
import 'package:rehab_care/web_services/web_services_export.dart';

import '../../../../bloc/bloc_export.dart';
import '../../model/treat_plan.dart';

part 'treat_plans_event.dart';

part 'treat_plans_state.dart';

class TreatPlansBloc extends Bloc<TreatPlansEvent, TreatPlansState> {
  TreatPlansBloc() : super(TreatPlansInitial()) {
    on<TreatPlansEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetTreatPlanEvent>(_getTreat);
    on<GetTreatPlanInfo>(_getTreatInfo);
    on<AddReport>(_addReport);
  }

  _getTreat(GetTreatPlanEvent event, Emitter<TreatPlansState> emit) async {
    emit(TreatPlansInitial());
    try {
      Response response = await myDio.post(EndPoints.planChild,
          queryParameters: {
            "child_id": event.childId,
            "id_major": event.majorId
          });
      if (response.statusCode == 200) {
        try {
          List<dynamic> raw = jsonDecode(response.data);
          List<TreatPlan> plans = [];
          for (int i = 0; i < raw.length; i++) {
            plans.add(TreatPlan.fromJson(raw[i]));
          }
          emit(TreatPlansDone(list: plans));
        } catch (error) {
          emit(PlanIsEmptyState());
          var ch = jsonDecode(response.toString());
          if (ch['status'].toString() == "0") {
            printLog("=====> I'm hare GetTreatPlanEvent");
          }
        }
      } else {
        emit(TreatError());
      }
    } catch (e) {
      emit(TreatError());
    }
  }

  _getTreatInfo(GetTreatPlanInfo event, Emitter<TreatPlansState> emit) async {
    emit(TreatPlansInitial());
    try {
      Response response =
          await myDio.post(EndPoints.selectPlans, queryParameters: {
        "plan_id": event.id.toString(),
      });
      if (response.statusCode == 200) {
        List raw = jsonDecode(response.data);
        emit(TreatPlanInfoDone(
            treatmentPlanData: TreatmentPlanData.fromJson(raw[0])));
      } else {
        emit(TreatError());
      }
    } catch (e) {
      emit(TreatError());
    }
  }

  _addReport(AddReport event, Emitter<TreatPlansState> emit) async {
    emit(TreatPlansInitial());
    List<MultipartFile> files = [];
    for (Attachment a in attachments) {
      String mimi = lookupMimeType(a.file.path) ?? "";
      files.add(MultipartFile.fromFileSync(a.file.path,
          contentType: MediaType.parse(mimi),
          filename: a.file.path.split("/").last));
    }
    FormData formData =
        FormData.fromMap({"child_id": event.childId, "image[]": files});
    try {
      Response response = await myDio.post(EndPoints.uploadReport,
          data: formData,
          options: Options(
              sendTimeout: 999999 * 9999,
              receiveTimeout: 999999 * 9999,
              contentType: "multipart/form-data"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        emit(AddReportDone(res: data['status']));
      } else {
        emit(TreatError());
      }
    } catch (e) {
      emit(TreatError());
    }
  }
}
