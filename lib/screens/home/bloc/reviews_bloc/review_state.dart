part of 'review_bloc.dart';

@immutable
abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewError extends ReviewState {}

class GetQuestionsDone extends ReviewState {
  final List<QuestionModel> data;

  GetQuestionsDone({required this.data});
}

class GetReviewDone extends ReviewState {
  final List<ReviewModel> data;

  GetReviewDone({required this.data});
}

class GetAnswerDone extends ReviewState {
  final AnswerModel? answerModel;

  GetAnswerDone({this.answerModel});
}

class SendAnswerDone extends ReviewState {}

class SendAnswerError extends ReviewState {}
