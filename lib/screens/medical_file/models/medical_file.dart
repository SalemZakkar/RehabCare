/// medical_id : "2"
/// healer_id : "1"
/// user_id : "2"
/// child_id : "8"
/// medical_report : "https://aboutcare.net/healer/assets/pdf/pdf_8722269.pdf"
/// sub_date : "08/10/2021 11:27:53 PM"

class MedicalFile {
  MedicalFile({
    String? medicalId,
    String? healerId,
    String? userId,
    String? childId,
    String? medicalReport,
    String? subDate,
  }) {
    _medicalId = medicalId;
    _healerId = healerId;
    _userId = userId;
    _childId = childId;
    _medicalReport = medicalReport;
    _subDate = subDate;
  }

  MedicalFile.fromJson(dynamic json) {
    _medicalId = json['medical_id'];
    _healerId = json['healer_id'];
    _userId = json['user_id'];
    _childId = json['child_id'];
    _medicalReport = json['medical_report'];
    _subDate = json['sub_date'];
  }

  String? _medicalId;
  String? _healerId;
  String? _userId;
  String? _childId;
  String? _medicalReport;
  String? _subDate;

  MedicalFile copyWith({
    String? medicalId,
    String? healerId,
    String? userId,
    String? childId,
    String? medicalReport,
    String? subDate,
  }) =>
      MedicalFile(
        medicalId: medicalId ?? _medicalId,
        healerId: healerId ?? _healerId,
        userId: userId ?? _userId,
        childId: childId ?? _childId,
        medicalReport: medicalReport ?? _medicalReport,
        subDate: subDate ?? _subDate,
      );

  String? get medicalId => _medicalId;

  String? get healerId => _healerId;

  String? get userId => _userId;

  String? get childId => _childId;

  String? get medicalReport => _medicalReport;

  String? get subDate => _subDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['medical_id'] = _medicalId;
    map['healer_id'] = _healerId;
    map['user_id'] = _userId;
    map['child_id'] = _childId;
    map['medical_report'] = _medicalReport;
    map['sub_date'] = _subDate;
    return map;
  }
}
