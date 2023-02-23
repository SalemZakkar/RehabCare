part of 'review_bloc.dart';

@immutable
abstract class ReviewEvent {}

class GetReviewsEvent extends ReviewEvent {
  final String childId;
  final String majorId;

  GetReviewsEvent({required this.childId, required this.majorId});
}

class GetQuestionEvent extends ReviewEvent {
  final String evaId;

  GetQuestionEvent({required this.evaId});
}

class CheckQuestionEvent extends ReviewEvent {
  final String questionId;

  CheckQuestionEvent({required this.questionId});
}

class SendAnswerEvent extends ReviewEvent {
  final List<String> qIds;
  final List<String> answers;
  final String childId;
  final String evaId;

  SendAnswerEvent(
      {required this.childId,
      required this.qIds,
      required this.answers,
      required this.evaId});
}

class ResetReview extends ReviewEvent {
  final String evaId;

  ResetReview({required this.evaId});
}
