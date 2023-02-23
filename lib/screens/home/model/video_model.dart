import 'dart:convert';

/// id_video : "4"
/// healer_id : "1"
/// child_id : "18"
/// title_video : "الفيديو الأول"
/// part_text : "هذا الفيديو يخص موضوع "
/// full_text : "هذا الفيديو يخص موضوع العلاج الخاصفي الطفل"
/// cover_video : "http://aboutcare.net/healer/assets/video/cover_video_7246181.png"
/// url_video : "https://aboutcare.net/healer/assets/video/video_1495378.mp4"
/// status : "active"
/// id_major : "1"
/// sub_date : "28/10/2021 04:51:19 PM"

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  VideoModel({
    String? idVideo,
    String? healerId,
    String? childId,
    String? titleVideo,
    String? partText,
    String? fullText,
    String? coverVideo,
    String? urlVideo,
    String? status,
    String? idMajor,
    String? subDate,
  }) {
    _idVideo = idVideo;
    _healerId = healerId;
    _childId = childId;
    _titleVideo = titleVideo;
    _partText = partText;
    _fullText = fullText;
    _coverVideo = coverVideo;
    _urlVideo = urlVideo;
    _status = status;
    _idMajor = idMajor;
    _subDate = subDate;
  }

  VideoModel.fromJson(dynamic json) {
    _idVideo = json['id_video'];
    _healerId = json['healer_id'];
    _childId = json['child_id'];
    _titleVideo = json['title_video'];
    _partText = json['part_text'];
    _fullText = json['full_text'];
    _coverVideo = json['cover_video'];
    _urlVideo = json['url_video'];
    _status = json['status'];
    _idMajor = json['id_major'];
    _subDate = json['sub_date'];
  }

  String? _idVideo;
  String? _healerId;
  String? _childId;
  String? _titleVideo;
  String? _partText;
  String? _fullText;
  String? _coverVideo;
  String? _urlVideo;
  String? _status;
  String? _idMajor;
  String? _subDate;

  VideoModel copyWith({
    String? idVideo,
    String? healerId,
    String? childId,
    String? titleVideo,
    String? partText,
    String? fullText,
    String? coverVideo,
    String? urlVideo,
    String? status,
    String? idMajor,
    String? subDate,
  }) =>
      VideoModel(
        idVideo: idVideo ?? _idVideo,
        healerId: healerId ?? _healerId,
        childId: childId ?? _childId,
        titleVideo: titleVideo ?? _titleVideo,
        partText: partText ?? _partText,
        fullText: fullText ?? _fullText,
        coverVideo: coverVideo ?? _coverVideo,
        urlVideo: urlVideo ?? _urlVideo,
        status: status ?? _status,
        idMajor: idMajor ?? _idMajor,
        subDate: subDate ?? _subDate,
      );

  String? get idVideo => _idVideo;

  String? get healerId => _healerId;

  String? get childId => _childId;

  String? get titleVideo => _titleVideo;

  String? get partText => _partText;

  String? get fullText => _fullText;

  String? get coverVideo => _coverVideo;

  String? get urlVideo => _urlVideo;

  String? get status => _status;

  String? get idMajor => _idMajor;

  String? get subDate => _subDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_video'] = _idVideo;
    map['healer_id'] = _healerId;
    map['child_id'] = _childId;
    map['title_video'] = _titleVideo;
    map['part_text'] = _partText;
    map['full_text'] = _fullText;
    map['cover_video'] = _coverVideo;
    map['url_video'] = _urlVideo;
    map['status'] = _status;
    map['id_major'] = _idMajor;
    map['sub_date'] = _subDate;
    return map;
  }
}
