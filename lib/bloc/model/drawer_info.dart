import 'dart:convert';

/// user_id : "2"
/// name : "assi"
/// ios_url : "IOS"
/// playstore_url : "PLAYSTORE"

DrawerInfo drawerInfoFromJson(String str) =>
    DrawerInfo.fromJson(json.decode(str));

String drawerInfoToJson(DrawerInfo data) => json.encode(data.toJson());

class DrawerInfo {
  DrawerInfo({
    String? userId,
    String? name,
    String? iosUrl,
    String? playStoreUrl,
  }) {
    _userId = userId;
    _name = name;
    _iosUrl = iosUrl;
    _playStoreUrl = playStoreUrl;
  }

  DrawerInfo.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _iosUrl = json['ios_url'];
    _playStoreUrl = json['playstore_url'];
  }

  String? _userId;
  String? _name;
  String? _iosUrl;
  String? _playStoreUrl;

  DrawerInfo copyWith({
    String? userId,
    String? name,
    String? iosUrl,
    String? playStoreUrl,
  }) =>
      DrawerInfo(
        userId: userId ?? _userId,
        name: name ?? _name,
        iosUrl: iosUrl ?? _iosUrl,
        playStoreUrl: playStoreUrl ?? _playStoreUrl,
      );

  String? get userId => _userId;

  String? get name => _name;

  String? get iosUrl => _iosUrl;

  String? get playStoreUrl => _playStoreUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['ios_url'] = _iosUrl;
    map['playstore_url'] = _playStoreUrl;
    return map;
  }
}
