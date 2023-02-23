import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:rehab_care/screens/home/home_export.dart';

import '../../../config/config_export.dart';
import '../../../web_services/web_services_export.dart';
import '../../authentication/models/models_export.dart';
import '../model/banner_model.dart';
import '../model/model_export.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial([], [])) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ChildrenParentGetEvent>(_childrenParentGetEvent);
    on<ChildrenParentUpdateEvent>(_childrenParentUpdateEvent);
    on<ChildrenParentAddEvent>(_childrenParentAddEvent);
    on<ChildrenParentDeleteEvent>(_childrenParentDeleteEvent);
    on<MajorGetEvent>(_majorGetEvent);
    on<DeleteAttachmentEvent>(_deleteAttachment);
    on<StopHomeEvent>(_stopApp);
    on<GetAllVideoEvent>(_getAllVideoEvent);
    on<GetTherapeuticSessionsEvent>(_getTherapeuticSessionsEvent);
    on<UploadAssessmentVideoEvent>(_uploadAssessmentVideoEvent);
    on<StopUploadingEvent>(_stopUpload);
  }

  _childrenParentGetEvent(
      ChildrenParentGetEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial(state.listChildrenParent, state.listMajor));
    try {
      final Response resGetChildrenParent =
          await myDio.post(EndPoints.childrenParent, queryParameters: {
        "user_id": event.myUserLogin.data,
      });
      final Response response2 = await myDio.get(EndPoints.banner);
      List raw = jsonDecode(response2.data);
      List<BannerModel> banner = [];
      for (var element in raw) {
        banner.add(BannerModel.fromJson(element));
      }
      if (resGetChildrenParent.statusCode == 200) {
        List<ChildrenParent> listChildrenParent = [];

        List<dynamic> resList = jsonDecode(resGetChildrenParent.toString());

        for (var element in resList) {
          listChildrenParent.add(ChildrenParent.fromJson(element));
        }

        emit(ChildrenParentGetState(listChildrenParent, state.listMajor,
            bannerModel: banner));
      } else {
        emit(ChildrenParentGetState(state.listChildrenParent, state.listMajor,
            bannerModel: banner));
      }
    } catch (error) {
      emit(const ChildrenParentErrorState([], "", []));
      printLog(error.toString());
    }
  }

  _stopApp(StopHomeEvent event, Emitter<HomeState> emit) {
    emit(const ChildrenParentErrorState([], "", []));
  }

  _deleteAttachment(DeleteAttachmentEvent event, Emitter<HomeState> emit) {
    attachments.removeWhere((element) => event.name == element.name);
    emit(DeleteAttachmentState(
        name: event.name, state.listChildrenParent, state.listMajor));
    emit(AttachmentInitial(state.listChildrenParent, state.listMajor));
  }

  _childrenParentUpdateEvent(
      ChildrenParentUpdateEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial(state.listChildrenParent, state.listMajor));
    try {
      MultipartFile? multipartFile;
      if (event.state == 2) {
        multipartFile = await MultipartFile.fromFile(
            event.photo?.path ?? File("").path,
            contentType:
                MediaType("image", event.photo?.path.split(".").last ?? ""));
      }
      if (event.state == 1) {
        multipartFile = null;
      }
      if (event.state == 0) {
        Uint8List bytes = (await NetworkAssetBundle(
                    Uri.parse(event.oldChildrenParent.photo ?? ""))
                .load(event.oldChildrenParent.photo ?? ""))
            .buffer
            .asUint8List();
        multipartFile = MultipartFile.fromBytes(bytes,
            contentType: MediaType(
                "image", event.oldChildrenParent.photo?.split(".").last ?? ""),
            filename:
                "${event.oldChildrenParent.userId!}.${event.oldChildrenParent.photo?.split(".").last ?? ""}");
      }

      ///0 nothing
      ///1 remove -------->
      FormData formData = FormData.fromMap({
        'child_id': event.oldChildrenParent.childId,
        'name': event.newChildrenParent.childName,
        'age': event.newChildrenParent.age,
        'gender': event.newChildrenParent.gender,
        'notes': event.newChildrenParent.status,
        "image": multipartFile
      });

      final Response resUpdateChildrenParent =
          await myDio.post(EndPoints.updateChildren, data: formData);
      if (resUpdateChildrenParent.statusCode == 200) {
        emit(ChildrenParentUpdateState(
            state.listChildrenParent, state.listMajor));
      } else {
        printLog('======= no update');
      }
    } catch (error) {
      emit(ChildrenParentErrorState(
          state.listChildrenParent, "error update", state.listMajor));
      printLog(error.toString());
    }
  }

  _childrenParentAddEvent(
      ChildrenParentAddEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial(state.listChildrenParent, state.listMajor));
    try {
      FormData formData = FormData.fromMap({
        "name": event.childrenParent.childName,
        "user_id": event.myUserInfo.userId,
        "age": event.childrenParent.age,
        "gender": "no value",
        "notes": event.notes,
        "status": event.childrenParent.status,
        "image": (event.photo != null
            ? await MultipartFile.fromFile(event.photo?.path ?? "",
                contentType:
                    MediaType("image", event.photo?.path.split(".").last ?? ""))
            : null),
        // 'image': await MultipartFile.fromFile('./text.txt',filename: 'upload.txt')
      });
      var resAddChildrenParent = await myDio.post(
        EndPoints.addChildren,
        data: formData,
      );

      List att = [];
      for (var element in attachments) {
        att.add(element.file);
      }
      bool can = true;
      if (att.isNotEmpty) {
        var raw = jsonDecode(resAddChildrenParent.data);
        Response response = await myDio.post(EndPoints.uploadReport,
            queryParameters: {"child_id": raw["child_id"], "images": att});
        if (response.statusCode != 200) {
          can = false;
        }
      }
      if (resAddChildrenParent.statusCode == 200 && can) {
        Map<String, dynamic> resAdd =
            jsonDecode(resAddChildrenParent.data.toString());

        ChildrenParent newChildrenParent = event.childrenParent.copyWith(
          userId: event.myUserInfo.userId,
          childId: resAdd["child_id"].toString(),
        );

        List<ChildrenParent> listChildrenParent = state.listChildrenParent;
        listChildrenParent.add(newChildrenParent);
        emit(ChildrenParentAddState(
            listChildrenParent, state.listMajor, newChildrenParent));
      } else {
        emit(ChildrenParentErrorState(
          state.listChildrenParent,
          "",
          state.listMajor,
        ));
        printLog("else${resAddChildrenParent.toString()}");
      }
    } catch (error) {
      emit(ChildrenParentErrorState(
        state.listChildrenParent,
        "",
        state.listMajor,
      ));
      printLog(error.toString());
    }
  }

  _childrenParentDeleteEvent(
      ChildrenParentDeleteEvent event, Emitter<HomeState> emit) async {
    // emit(const HomeInitial([], []));
    try {
      Response resDeleteChildrenParent = await myDio.post(
        EndPoints.deleteChildren,
        queryParameters: {
          "user_id": event.myUserInfo.userId,
          'password': event.myUserInfo.password,
          "child_id": event.childrenParent.childId,
        },
      );

      if (resDeleteChildrenParent.statusCode == 200) {
        List<ChildrenParent> listChildrenParent = state.listChildrenParent;
        listChildrenParent.remove(event.childrenParent);
        emit(ChildrenParentDeleteState(listChildrenParent, state.listMajor));
      } else {
        emit(ChildrenParentErrorState(state.listChildrenParent,
            'error body delete children', state.listMajor));
      }
    } catch (error) {
      emit(ChildrenParentErrorState(state.listChildrenParent,
          'error body delete children', state.listMajor));
      printLog(error.toString());
    }
  }

  _majorGetEvent(MajorGetEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial(state.listChildrenParent, state.listMajor));
    try {
      Response resGetMajor = await myDio.post(EndPoints.major);

      if (resGetMajor.statusCode == 200) {
        List<Major> listMajor = [];
        List<dynamic> resList = jsonDecode(resGetMajor.toString());

        for (var element in resList) {
          listMajor.add(Major.fromJson(element));
        }
        emit(MajorGetState(state.listChildrenParent, listMajor));
      } else {
        emit(ChildrenParentErrorState(
            state.listChildrenParent, "error get Major", state.listMajor));
      }
    } catch (error) {
      emit(ChildrenParentErrorState(
          state.listChildrenParent, "error get Major", state.listMajor));
      printLog(error);
    }
  }

  _getAllVideoEvent(GetAllVideoEvent event, Emitter<HomeState> emit) async {
    emit(GetAllVideoState(
        state.listChildrenParent, state.listMajor, const [], true));
    try {
      Response resGetAllVideo = await myDio.get(
        EndPoints.allVideoChildren,
        queryParameters: {
          "child_id": event.childId.toString(),
          "id_major": event.majorId.toString()
        },
      );

      if (resGetAllVideo.statusCode == 200) {
        try {
          List<dynamic> listRes = jsonDecode(resGetAllVideo.toString());
          List<VideoModel> listVideoModel = [];
          for (var element in listRes) {
            listVideoModel.add(VideoModel.fromJson(element));
          }
          emit(GetAllVideoState(state.listChildrenParent, state.listMajor,
              listVideoModel, false));
        } catch (error) {
          emit(GetAllVideoState(
              state.listChildrenParent, state.listMajor, const [], false));
          var ch = jsonDecode(resGetAllVideo.toString());
          if (ch['status'].toString() == "0") {
            printLog("=====> I'm hare 4566");
          }
        }
      } else {
        printLog("error get all video");
      }
    } catch (error) {
      emit(HomeError(state.listChildrenParent, state.listMajor));
      printLog(error.toString());
    }
  }

  _getTherapeuticSessionsEvent(
      GetTherapeuticSessionsEvent event, Emitter<HomeState> emit) async {
    emit(GetTherapeuticSessionsState(
        state.listChildrenParent, state.listMajor, const [], true));
    try {
      Response res = await myDio.post(
        EndPoints.allAssessmentVideo,
        queryParameters: {
          "child_id": event.childId.toString(),
          "id_major": event.majorId.toString()
        },
      );

      if (res.statusCode == 200) {
        try {
          List<dynamic> listRes = jsonDecode(res.toString());
          List<AllAssessmentVideo> listAllAssessmentVideo = [];
          for (var element in listRes) {
            listAllAssessmentVideo.add(AllAssessmentVideo.fromJson(element));
          }
          emit(GetTherapeuticSessionsState(
            state.listChildrenParent,
            state.listMajor,
            listAllAssessmentVideo,
            false,
          ));
        } catch (error) {
          emit(GetTherapeuticSessionsState(
              state.listChildrenParent, state.listMajor, const [], false));
          var ch = jsonDecode(res.toString());
          if (ch['status'].toString() == "0") {
            printLog("=====> I'm hare GetTherapeuticSessionsEvent");
          }
        }
      } else {
        printLog("error GetTherapeuticSessionsEvent");
      }
    } catch (error) {
      emit(HomeError(state.listChildrenParent, state.listMajor));
      printLog(error.toString());
    }
  }

  ///TODO iamHareUpload 4
  _uploadAssessmentVideoEvent(
      UploadAssessmentVideoEvent event, Emitter<HomeState> emit) async {
    String type = event.videoFile.path.split(".").last;
    List<String> types = ["mp4", "3gp", "avi", "mov", "mpeg"];
    if (!types.contains(type.toLowerCase())) {
      emit(UploadErrorState(state.listChildrenParent, state.listMajor,
          errorBody: S.current.not_supported_video));
      emit(UploadAssessmentVideoState(state.listChildrenParent, state.listMajor,
          sending: 0,
          total: 0,
          presenting: "",
          isLoading: false,
          isDone: true));
    } else {
      try {
        String mime = lookupMimeType(event.videoFile.path) ?? "*/*";
        printLog("mimeType ===>$mime");
        printLog("assessmentId ===>${event.assessmentId}");
        printLog("mimeType ===>${event.videoFile.path}");

        /// TODO Test 1
        // MultipartFile multipartFile = MultipartFile.fromFileSync(
        //   event.videoFile.path,
        //   filename: event.videoFile.path.split("/").last,
        //   contentType: MediaType(mime.split("/").first, mime.split("/").last),
        // );

        /// TODO Test 2
        // MultipartFile multipartFile = MultipartFile(
        //   event.videoFile.openRead(),
        //   await event.videoFile.length(),
        //   filename: event.videoFile.path.split("/").last,
        //   contentType: MediaType(mime.split("/").first, mime.split("/").last),
        // );

        /// TODO Test 3
        // MultipartFile multipartFile = MultipartFile(
        //   event.videoFile.openRead(),
        //   await event.videoFile.length(),
        //   filename: event.videoFile.path.split("/").last,
        //   contentType: MediaType(mime.split("/").first, mime.split("/").last),
        // );

        FormData formData = FormData.fromMap(
          {
            "assessment_id": event.assessmentId,
          },
        );

        MultipartFile multipartFile = MultipartFile.fromFileSync(
          event.videoFile.path,
          filename: event.videoFile.path.split("/").last,
          contentType: MediaType(mime.split("/").first, mime.split("/").last),
        );

        formData.files.add(MapEntry("videoFile", multipartFile));
        initUpload();
        Response response = await uploadDio.post(
          EndPoints.uploadAssessmentVideo,
          data: formData,
          onSendProgress: (current, total) {
            emit(UploadAssessmentVideoState(
              state.listChildrenParent,
              state.listMajor,
              isLoading: true,
              isDone: false,
              sending: current,
              total: total,
              presenting: "${((current / total) * 100).toStringAsFixed(2)}%",
            ));
          },
          cancelToken: cancelToken,
          options: Options(
            followRedirects: true,
            sendTimeout: 9999999999999,
            receiveTimeout: 999999999999,
            contentType: "multipart/form-data",
            headers: {
              "Accept": "*/*",
              "Connection": "keep-alive",
            },
          ),
        );

        if (response.statusCode == 200) {
          var ch = jsonDecode(response.toString());
          if (ch['status'].toString() == "1") {
            emit(UploadDone(state.listChildrenParent, state.listMajor));
            emit(UploadAssessmentVideoState(
                state.listChildrenParent, state.listMajor,
                sending: 0,
                total: 0,
                presenting: "",
                isLoading: false,
                isDone: true));
          } else if (ch['status'].toString() == "0") {
            emit(UploadErrorState(state.listChildrenParent, state.listMajor,
                errorBody: S.current.temp_error));
            emit(UploadAssessmentVideoState(
                state.listChildrenParent, state.listMajor,
                sending: 0,
                total: 0,
                presenting: "",
                isLoading: false,
                isDone: true));
          } else if (ch['status'].toString() ==
              "extension not allowed, please choose a mp4 , mov , 3gp or mpeg file") {
            emit(UploadErrorState(state.listChildrenParent, state.listMajor,
                errorBody: S.current.temp_error));
            emit(UploadAssessmentVideoState(
                state.listChildrenParent, state.listMajor,
                sending: 0,
                total: 0,
                presenting: "presenting",
                isLoading: false,
                isDone: true));
          } else {
            /// not found file
            emit(UploadErrorState(state.listChildrenParent, state.listMajor,
                errorBody: S.current.temp_error));
            emit(UploadAssessmentVideoState(
                state.listChildrenParent, state.listMajor,
                sending: 0,
                total: 0,
                presenting: "",
                isLoading: false,
                isDone: true));
          }
        } else {
          emit(UploadErrorState(state.listChildrenParent, state.listMajor,
              errorBody: S.current.error));
          emit(UploadAssessmentVideoState(
              state.listChildrenParent, state.listMajor,
              sending: 0,
              total: 0,
              presenting: "",
              isLoading: false,
              isDone: true));
        }
      } catch (error) {
        emit(HomeError(state.listChildrenParent, state.listMajor));
        printLog(error.toString());
      }
    }
  }
}

Dio uploadDio = Dio();
CancelToken cancelToken = CancelToken();

void initUpload() {
  uploadDio = Dio(
    BaseOptions(
      connectTimeout: 12000,
      receiveTimeout: 12000,
      sendTimeout: 12000,
      headers: {
        "Accept": "*/*",
        "Connection": "keep-alive",
      },
      baseUrl: EndPoints.baseUrl,
      responseType: ResponseType.plain,
    ),
  );
  uploadDio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      requestBody: true,
      responseHeader: true,
      requestHeader: true,
      request: true,
    ),
  );
}

_stopUpload(StopUploadingEvent event, Emitter<HomeState> emit) {
  cancelToken.cancel();
  cancelToken = CancelToken();
  uploadDio.close(force: true);
  debugPrint("cancel Upload Task");
  debugPrint(
      "------------------------------------------------------------------->");
}
