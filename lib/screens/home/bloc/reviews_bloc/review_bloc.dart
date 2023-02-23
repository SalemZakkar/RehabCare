import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rehab_care/screens/home/model/answer_model.dart';
import 'package:rehab_care/web_services/web_services_export.dart';

import '../../../../bloc/bloc_export.dart';
import '../../../../config/config_export.dart';
import '../../model/question_model.dart';
import '../../model/review_model.dart';

part 'review_event.dart';

part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial()) {
    on<ReviewEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetReviewsEvent>(_getAllReviews);
    on<GetQuestionEvent>(_getQuestion);
    on<ResetReview>(_reset);
    on<CheckQuestionEvent>(_getQuestionInfo);
    on<SendAnswerEvent>(_sendAnswers);
  }

  _getAllReviews(GetReviewsEvent event, Emitter<ReviewState> emit) async {
    emit(ReviewInitial());
    try {
      Response response = await myDio.post(EndPoints.ratingChild,
          queryParameters: {
            "child_id": event.childId,
            "id_major": event.majorId
          });
      if (response.statusCode == 200) {
        try {
          List<dynamic> raw = jsonDecode(response.data);
          List<ReviewModel> data = [];
          for (int i = 0; i < raw.length; i++) {
            data.add(ReviewModel.fromJson(raw[i]));
            emit(GetReviewDone(data: data));
          }
        } catch (error) {
          emit(GetReviewDone(data: const []));
          var ch = jsonDecode(response.toString());
          if (ch['status'].toString() == "0") {
            printLog("=====> I'm hare GetReviewsEvent");
          }
        }
      } else {
        emit(ReviewError());
      }
    } catch (e) {
      emit(ReviewError());
    }
  }

  _getQuestion(GetQuestionEvent event, Emitter<ReviewState> emit) async {
    emit(ReviewInitial());
    try {
      Response response = await myDio.post(EndPoints.ratingQuestion,
          queryParameters: {"eva_id": event.evaId});
      if (response.statusCode == 200) {
        List raw = jsonDecode(response.data);
        List<QuestionModel> data = [];
        for (int i = 0; i < raw.length; i++) {
          data.add(QuestionModel.fromJson(raw[i]));
        }
        emit(GetQuestionsDone(data: data));
      } else {
        emit(ReviewError());
      }
    } on DioError {
      emit(ReviewError());
    } catch (e) {
      emit(GetQuestionsDone(data: const []));
    }
  }

  _reset(ResetReview event, Emitter<ReviewState> emit) async {
    emit(ReviewInitial());
    try {
      Response response = await myDio.post(EndPoints.ratingQuestion,
          queryParameters: {"eva_id": event.evaId});
      if (response.statusCode == 200) {
        List raw = jsonDecode(response.data);
        List<QuestionModel> data = [];
        for (int i = 0; i < raw.length; i++) {
          data.add(QuestionModel.fromJson(raw[i]));
        }
        emit(GetQuestionsDone(data: data));
      } else {
        emit(ReviewError());
      }
    } on DioError {
      emit(ReviewError());
    } catch (e) {
      emit(GetQuestionsDone(data: const []));
    }
  }

  _getQuestionInfo(CheckQuestionEvent event, Emitter<ReviewState> emit) async {
    try {
      Response response = await myDio.post(EndPoints.ratingAnswer,
          queryParameters: {"question_id": event.questionId});
      if (response.statusCode == 200) {
        List raw = jsonDecode(response.data);
        emit(GetAnswerDone(answerModel: AnswerModel.fromJson(raw.last)));
      }
    } on DioError {
      emit(ReviewError());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

_sendAnswers(SendAnswerEvent event, Emitter<ReviewState> emit) async {
  try {
    String qIds = event.qIds.toString();
    qIds = qIds
        .replaceAll(RegExp(r"\["), "")
        .replaceAll(RegExp(r"\]"), "")
        .replaceAll(" ", "");
    if (kDebugMode) {
      print(qIds);
    }
    String answers = event.answers.toString();
    answers = answers
        .replaceAll(RegExp(r"\["), "")
        .replaceAll(RegExp(r"\]"), "")
        .replaceAll(" ", "");
    if (kDebugMode) {
      print(answers);
    }
    Response response =
        await myDio.post(EndPoints.returnAnswer, queryParameters: {
      "eva_id": event.evaId,
      "child_id": event.childId,
      "question_id": qIds,
      "answer": answers
    });
    if (response.statusCode == 200) {
      emit(SendAnswerDone());
    } else {
      emit(ReviewError());
    }
  } catch (e) {
    emit(ReviewError());
  }
}

Map<int, AnswerModel> answers = {};
