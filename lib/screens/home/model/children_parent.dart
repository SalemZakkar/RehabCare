import 'dart:convert';

/// child_id : "8"
/// child_name : "mohammad Alassi"
/// user_id : "2"
/// age : "26-04-2006"
/// gender : "M"
/// added_date : "23/09/2021 01:35:25 PM"
/// photo : "http://dashboard.aboutcare.net/assets/images/image_children/image_children_8486751.jpg"
/// status : "active"

ChildrenParent childrenParentFromJson(String str) =>
    ChildrenParent.fromJson(json.decode(str));

String childrenParentToJson(ChildrenParent data) => json.encode(data.toJson());

class ChildrenParent {
  ChildrenParent({
    String? childId,
    String? childName,
    String? userId,
    String? age,
    String? gender,
    String? addedDate,
    String? photo,
    String? status,
  }) {
    _childId = childId;
    _childName = childName;
    _userId = userId;
    _age = age;
    _gender = gender;
    _addedDate = addedDate;
    _photo = photo;
    _status = status;
  }

  ChildrenParent.fromJson(dynamic json) {
    _childId = json['child_id'].toString();
    _childName = json['child_name'].toString();
    _userId = json['user_id'].toString();
    _age = json['age'].toString();
    _gender = json['gender'].toString();
    _addedDate = json['added_date'].toString();
    _photo = json['photo'].toString();
    _status = json['status'].toString();
  }

  String? _childId;
  String? _childName;
  String? _userId;
  String? _age;
  String? _gender;
  String? _addedDate;
  String? _photo;
  String? _status;

  ChildrenParent copyWith({
    String? childId,
    String? childName,
    String? userId,
    String? age,
    String? gender,
    String? addedDate,
    String? photo,
    String? status,
  }) =>
      ChildrenParent(
        childId: childId ?? _childId,
        childName: childName ?? _childName,
        userId: userId ?? _userId,
        age: age ?? _age,
        gender: gender ?? _gender,
        addedDate: addedDate ?? _addedDate,
        photo: photo ?? _photo,
        status: status ?? _status,
      );

  String? get childId => _childId;

  String? get childName => _childName;

  String? get userId => _userId;

  String? get age => _age;

  String? get gender => _gender;

  String? get addedDate => _addedDate;

  String? get photo => _photo;

  String? get status => _status;

  void setPhoto(String? photo) {
    _photo = photo;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['child_id'] = _childId;
    map['child_name'] = _childName;
    map['user_id'] = _userId;
    map['age'] = _age;
    map['gender'] = _gender;
    map['added_date'] = _addedDate;
    map['photo'] = _photo;
    map['status'] = _status;
    return map;
  }
}
