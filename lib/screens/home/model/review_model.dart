/// eva_id : "3"
/// child_id : "18"
/// eva_name : "التقييم الاول"
/// healer_id : "1"
/// date_time : "28/10/2021 04:54:03 PM"
/// status : "active"
/// id_major : "1"
/// sub_date : "28/10/2021 04:54:03 PM"

class ReviewModel {
  ReviewModel({
    String? evaId,
    String? childId,
    String? evaName,
    String? healerId,
    String? dateTime,
    String? status,
    String? idMajor,
    String? subDate,
  }) {
    _evaId = evaId;
    _childId = childId;
    _evaName = evaName;
    _healerId = healerId;
    _dateTime = dateTime;
    _status = status;
    _idMajor = idMajor;
    _subDate = subDate;
  }

  ReviewModel.fromJson(dynamic json) {
    _evaId = json['eva_id'];
    _childId = json['child_id'];
    _evaName = json['eva_name'];
    _healerId = json['healer_id'];
    _dateTime = json['date_time'];
    _status = json['status'];
    _idMajor = json['id_major'];
    _subDate = json['sub_date'];
  }

  String? _evaId;
  String? _childId;
  String? _evaName;
  String? _healerId;
  String? _dateTime;
  String? _status;
  String? _idMajor;
  String? _subDate;

  ReviewModel copyWith({
    String? evaId,
    String? childId,
    String? evaName,
    String? healerId,
    String? dateTime,
    String? status,
    String? idMajor,
    String? subDate,
  }) =>
      ReviewModel(
        evaId: evaId ?? _evaId,
        childId: childId ?? _childId,
        evaName: evaName ?? _evaName,
        healerId: healerId ?? _healerId,
        dateTime: dateTime ?? _dateTime,
        status: status ?? _status,
        idMajor: idMajor ?? _idMajor,
        subDate: subDate ?? _subDate,
      );

  String? get evaId => _evaId;

  String? get childId => _childId;

  String? get evaName => _evaName;

  String? get healerId => _healerId;

  String? get dateTime => _dateTime;

  String? get status => _status;

  String? get idMajor => _idMajor;

  String? get subDate => _subDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eva_id'] = _evaId;
    map['child_id'] = _childId;
    map['eva_name'] = _evaName;
    map['healer_id'] = _healerId;
    map['date_time'] = _dateTime;
    map['status'] = _status;
    map['id_major'] = _idMajor;
    map['sub_date'] = _subDate;
    return map;
  }
}
