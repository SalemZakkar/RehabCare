/// notifications_id : "1"
/// user_id : "-1"
/// title : "Rehab CAre"
/// text : "test"
/// date_time : "21/09/2021 07:26:55 PM"
/// redirection : "0"
/// child_id : "0"

class Notifications {
  Notifications({
    String? notificationsId,
    String? userId,
    String? title,
    String? text,
    String? dateTime,
    String? redirection,
    String? childId,
  }) {
    _notificationsId = notificationsId;
    _userId = userId;
    _title = title;
    _text = text;
    _dateTime = dateTime;
    _redirection = redirection;
    _childId = childId;
  }

  Notifications.fromJson(dynamic json) {
    _notificationsId = json['notifications_id'];
    _userId = json['user_id'];
    _title = json['title'];
    _text = json['text'];
    _dateTime = json['date_time'];
    _redirection = json['redirection'];
    _childId = json['child_id'];
  }

  String? _notificationsId;
  String? _userId;
  String? _title;
  String? _text;
  String? _dateTime;
  String? _redirection;
  String? _childId;

  Notifications copyWith({
    String? notificationsId,
    String? userId,
    String? title,
    String? text,
    String? dateTime,
    String? redirection,
    String? childId,
  }) =>
      Notifications(
        notificationsId: notificationsId ?? _notificationsId,
        userId: userId ?? _userId,
        title: title ?? _title,
        text: text ?? _text,
        dateTime: dateTime ?? _dateTime,
        redirection: redirection ?? _redirection,
        childId: childId ?? _childId,
      );

  String? get notificationsId => _notificationsId;

  String? get userId => _userId;

  String? get title => _title;

  String? get text => _text;

  String? get dateTime => _dateTime;

  String? get redirection => _redirection;

  String? get childId => _childId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notifications_id'] = _notificationsId;
    map['user_id'] = _userId;
    map['title'] = _title;
    map['text'] = _text;
    map['date_time'] = _dateTime;
    map['redirection'] = _redirection;
    map['child_id'] = _childId;
    return map;
  }
}
