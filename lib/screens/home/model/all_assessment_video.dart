import 'dart:convert';

/// assessment_id : "5"
/// healer_id : "1"
/// child_id : "18"
/// title : "تصوير الطفل"
/// description : "تصوير الطفل وهو يركد"
/// video_url : "-"
/// req_date : "28/10/2021 04:53:35 PM"
/// sub_date : "16/07/2022 07:09:16 PM"
/// status : "active"
/// id_major : "1"

AllAssessmentVideo allAssessmentVideoFromJson(String str) =>
    AllAssessmentVideo.fromJson(json.decode(str));

String allAssessmentVideoToJson(AllAssessmentVideo data) =>
    json.encode(data.toJson());

class AllAssessmentVideo {
  AllAssessmentVideo({
    String? assessmentId,
    String? healerId,
    String? childId,
    String? title,
    String? description,
    String? videoUrl,
    String? reqDate,
    String? subDate,
    String? status,
    String? idMajor,
  }) {
    _assessmentId = assessmentId;
    _healerId = healerId;
    _childId = childId;
    _title = title;
    _description = description;
    _videoUrl = videoUrl;
    _reqDate = reqDate;
    _subDate = subDate;
    _status = status;
    _idMajor = idMajor;
  }

  AllAssessmentVideo.fromJson(dynamic json) {
    _assessmentId = json['assessment_id'];
    _healerId = json['healer_id'];
    _childId = json['child_id'];
    _title = json['title'];
    _description = json['description'];
    _videoUrl = json['video_url'];
    _reqDate = json['req_date'];
    _subDate = json['sub_date'];
    _status = json['status'];
    _idMajor = json['id_major'];
  }

  String? _assessmentId;
  String? _healerId;
  String? _childId;
  String? _title;
  String? _description;
  String? _videoUrl;
  String? _reqDate;
  String? _subDate;
  String? _status;
  String? _idMajor;

  AllAssessmentVideo copyWith({
    String? assessmentId,
    String? healerId,
    String? childId,
    String? title,
    String? description,
    String? videoUrl,
    String? reqDate,
    String? subDate,
    String? status,
    String? idMajor,
  }) =>
      AllAssessmentVideo(
        assessmentId: assessmentId ?? _assessmentId,
        healerId: healerId ?? _healerId,
        childId: childId ?? _childId,
        title: title ?? _title,
        description: description ?? _description,
        videoUrl: videoUrl ?? _videoUrl,
        reqDate: reqDate ?? _reqDate,
        subDate: subDate ?? _subDate,
        status: status ?? _status,
        idMajor: idMajor ?? _idMajor,
      );

  String? get assessmentId => _assessmentId;

  String? get healerId => _healerId;

  String? get childId => _childId;

  String? get title => _title;

  String? get description => _description;

  String? get videoUrl => _videoUrl;

  String? get reqDate => _reqDate;

  String? get subDate => _subDate;

  String? get status => _status;

  String? get idMajor => _idMajor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['assessment_id'] = _assessmentId;
    map['healer_id'] = _healerId;
    map['child_id'] = _childId;
    map['title'] = _title;
    map['description'] = _description;
    map['video_url'] = _videoUrl;
    map['req_date'] = _reqDate;
    map['sub_date'] = _subDate;
    map['status'] = _status;
    map['id_major'] = _idMajor;
    return map;
  }
}
