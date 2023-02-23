/// plan_id : "9"
/// plan_name : "الخطة العلاجية الثالثة"
/// plan_text : "الخطة العلاجية للاطفال الذي يجدون الصعوبة في التعلم يجب تدريب الاطفال على اصوات الحروف و اشكالها و النطق السليم لها.\r\n\r\nو تتضمن الخطة العلاجية لاطفال الذي يجدون صعوبة في التعلم وضعف لدى الطلاب:\r\n- تخصيص حصة تقوية للعلاج الطلبة.\r\n- يعطي طلاب واجبات تعالج الضعف.\r\n- تحفيزهم المستمر لطلبة معنوية و مادية.\r\n- استخدام طرق جديدة و اساليب مبتكرة للتعليم.\r\n- تقديم أنشطة تنشط ذهن و سهولة تقديم المعلومات المراد شرحها.\r\n- المتابعة المستمرة من قبل الوالدين للطلاب مع الاخصائية الاجتماعية."
/// sub_date : "28/10/2021 04:49:48 PM"

class TreatmentPlanData {
  TreatmentPlanData({
    String? planId,
    String? planName,
    String? planText,
    String? subDate,
  }) {
    _planId = planId;
    _planName = planName;
    _planText = planText;
    _subDate = subDate;
  }

  TreatmentPlanData.fromJson(dynamic json) {
    _planId = json['plan_id'];
    _planName = json['plan_name'];
    _planText = json['plan_text'];
    _subDate = json['sub_date'];
  }

  String? _planId;
  String? _planName;
  String? _planText;
  String? _subDate;

  TreatmentPlanData copyWith({
    String? planId,
    String? planName,
    String? planText,
    String? subDate,
  }) =>
      TreatmentPlanData(
        planId: planId ?? _planId,
        planName: planName ?? _planName,
        planText: planText ?? _planText,
        subDate: subDate ?? _subDate,
      );

  String? get planId => _planId;

  String? get planName => _planName;

  String? get planText => _planText;

  String? get subDate => _subDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['plan_id'] = _planId;
    map['plan_name'] = _planName;
    map['plan_text'] = _planText;
    map['sub_date'] = _subDate;
    return map;
  }
}
