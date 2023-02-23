import 'dart:convert';

/// id : "1"
/// data : "2"

MyUserLogin myUserLoginFromJson(String str) =>
    MyUserLogin.fromJson(json.decode(str));

String myUserLoginToJson(MyUserLogin data) => json.encode(data.toJson());

class MyUserLogin {
  MyUserLogin({
    String? id,
    String? data,
  }) {
    _id = id;
    _data = data;
  }

  MyUserLogin.fromJson(dynamic json) {
    _id = json['id'].toString();
    _data = json['data'].toString();
  }

  String? _id;
  String? _data;

  MyUserLogin copyWith({
    String? id,
    String? data,
  }) =>
      MyUserLogin(
        id: id ?? _id,
        data: data ?? _data,
      );

  String? get id => _id;

  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id.toString();
    map['data'] = _data;
    return map;
  }
}
