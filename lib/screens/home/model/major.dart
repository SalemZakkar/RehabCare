import 'dart:convert';

/// id : "1"
/// name : "Learning Disorders"

Major majorFromJson(String str) => Major.fromJson(json.decode(str));

String majorToJson(Major data) => json.encode(data.toJson());

class Major {
  Major({
    String? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Major.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  String? _id;
  String? _name;

  Major copyWith({
    String? id,
    String? name,
  }) =>
      Major(
        id: id ?? _id,
        name: name ?? _name,
      );

  String? get id => _id;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
