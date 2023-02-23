/// question_id : "37"
/// eva_id : "5"
/// question_text : "هل يستطيع الطفل تحريك يده اليمنى"
/// hint : "هل يستطيع الطفل تحريك يده اليمنى"

class QuestionModel {
  QuestionModel({
    String? questionId,
    String? evaId,
    String? questionText,
    String? hint,
  }) {
    _questionId = questionId;
    _evaId = evaId;
    _questionText = questionText;
    _hint = hint;
  }

  QuestionModel.fromJson(dynamic json) {
    _questionId = json['question_id'];
    _evaId = json['eva_id'];
    _questionText = json['question_text'];
    _hint = json['hint'];
  }

  String? _questionId;
  String? _evaId;
  String? _questionText;
  String? _hint;

  QuestionModel copyWith({
    String? questionId,
    String? evaId,
    String? questionText,
    String? hint,
  }) =>
      QuestionModel(
        questionId: questionId ?? _questionId,
        evaId: evaId ?? _evaId,
        questionText: questionText ?? _questionText,
        hint: hint ?? _hint,
      );

  String? get questionId => _questionId;

  String? get evaId => _evaId;

  String? get questionText => _questionText;

  String? get hint => _hint;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question_id'] = _questionId;
    map['eva_id'] = _evaId;
    map['question_text'] = _questionText;
    map['hint'] = _hint;
    return map;
  }
}
