/// answer_id : "3"
/// question_id : "3"
/// answer : "not"

class AnswerModel {
  AnswerModel({
    String? answerId,
    String? questionId,
    String? answer,
  }) {
    _answerId = answerId;
    _questionId = questionId;
    _answer = answer;
  }

  AnswerModel.fromJson(dynamic json) {
    _answerId = json['answer_id'];
    _questionId = json['question_id'];
    _answer = json['answer'];
  }

  String? _answerId;
  String? _questionId;
  String? _answer;

  AnswerModel copyWith({
    String? answerId,
    String? questionId,
    String? answer,
  }) =>
      AnswerModel(
        answerId: answerId ?? _answerId,
        questionId: questionId ?? _questionId,
        answer: answer ?? _answer,
      );

  String? get answerId => _answerId;

  String? get questionId => _questionId;

  String? get answer => _answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answer_id'] = _answerId;
    map['question_id'] = _questionId;
    map['answer'] = _answer;
    return map;
  }
}
