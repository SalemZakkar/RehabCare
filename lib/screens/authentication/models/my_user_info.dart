import 'dart:convert';

/// user_id : "2"
/// name : "assi"
/// email : "moalassi@uahoo.com"
/// city : "amman"
/// user_status : "active"
/// reg_date : "29/06/2021 03:39:59 PM"
/// last_login : "29/06/2021 03:39:59 PM"
/// phone : "+971797679985"
/// password : "e10adc3949ba59abbe56e057f20f883e"
/// token : "fRn_KOtTSIWKLNCRkRj-IH:APA91bHR7Plc4VOz-hTpVbN-SUq9aMxerrviA9T-qkTGBl4gR0TbxmQG7y6PQJ0NOJqYxhtZjG65PkmLxLbSt6FR7WfSHNlUFFZGS6F59J0rjsoPgknW4Dnibel3fbFaYsfjm4aTPBKD"

MyUserInfo myUserInfoFromJson(String str) =>
    MyUserInfo.fromJson(json.decode(str));

String myUserInfoToJson(MyUserInfo data) => json.encode(data.toJson());

class MyUserInfo {
  MyUserInfo({
    String? userId,
    String? name,
    String? email,
    String? city,
    String? userStatus,
    String? regDate,
    String? lastLogin,
    String? phone,
    String? password,
    String? token,
  }) {
    _userId = userId;
    _name = name;
    _email = email;
    _city = city;
    _userStatus = userStatus;
    _regDate = regDate;
    _lastLogin = lastLogin;
    _phone = phone;
    _password = password;
    _token = token;
  }

  MyUserInfo.fromJson(dynamic json) {
    _userId = json['user_id'].toString();
    _name = json['name'].toString();
    _email = json['email'].toString();
    _city = json['city'].toString();
    _userStatus = json['user_status'].toString();
    _regDate = json['reg_date'].toString();
    _lastLogin = json['last_login'].toString();
    _phone = json['phone'].toString();
    _password = json['password'].toString();
    _token = json['token'].toString();
  }

  String? _userId;
  String? _name;
  String? _email;
  String? _city;
  String? _userStatus;
  String? _regDate;
  String? _lastLogin;
  String? _phone;
  String? _password;
  String? _token;

  MyUserInfo copyWith({
    String? userId,
    String? name,
    String? email,
    String? city,
    String? userStatus,
    String? regDate,
    String? lastLogin,
    String? phone,
    String? password,
    String? token,
  }) =>
      MyUserInfo(
        userId: userId ?? _userId,
        name: name ?? _name,
        email: email ?? _email,
        city: city ?? _city,
        userStatus: userStatus ?? _userStatus,
        regDate: regDate ?? _regDate,
        lastLogin: lastLogin ?? _lastLogin,
        phone: phone ?? _phone,
        password: password ?? _password,
        token: token ?? _token,
      );

  String? get userId => _userId;

  String? get name => _name;

  String? get email => _email;

  String? get city => _city;

  String? get userStatus => _userStatus;

  String? get regDate => _regDate;

  String? get lastLogin => _lastLogin;

  String? get phone => _phone;

  String? get password => _password;

  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['city'] = _city;
    map['user_status'] = _userStatus;
    map['reg_date'] = _regDate;
    map['last_login'] = _lastLogin;
    map['phone'] = _phone;
    map['password'] = _password;
    map['token'] = _token;
    return map;
  }
}
