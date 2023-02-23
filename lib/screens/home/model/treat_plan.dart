/// child_id : "18"
/// plan_id : "9"
/// plan_name : "الخطة العلاجية الثالثة"

class TreatPlan {
  TreatPlan({
    String? childId,
    String? planId,
    String? planName,
  }) {
    _childId = childId;
    _planId = planId;
    _planName = planName;
  }

  TreatPlan.fromJson(dynamic json) {
    _childId = json['child_id'];
    _planId = json['plan_id'];
    _planName = json['plan_name'];
  }

  String? _childId;
  String? _planId;
  String? _planName;

  TreatPlan copyWith({
    String? childId,
    String? planId,
    String? planName,
  }) =>
      TreatPlan(
        childId: childId ?? _childId,
        planId: planId ?? _planId,
        planName: planName ?? _planName,
      );

  String? get childId => _childId;

  String? get planId => _planId;

  String? get planName => _planName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['child_id'] = _childId;
    map['plan_id'] = _planId;
    map['plan_name'] = _planName;
    return map;
  }
}
