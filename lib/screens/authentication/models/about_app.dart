import 'dart:convert';

/// title : "تواصل معنا\r\n"
/// text : "حول حدود خاصية إعادة التوجيه\r\nعند إعادة توجيه رسالة ما، يمكنك اختيار\r\nمشاركتها في خمس دردشات كحد أق￾￾\nفي\r\n آن واحد\r\nالرسائل المعاد توجيهها مشفرة تمامًا بين\r\nالطرفين\r\nيحتوي واتساب على عداد لتعقب عدد مرات\r\nإعادة\nتوجيه الرسائل. هذا العداد مشفر تمامًا\r\nبين الطرفين، وبذلك يمكن لجهازك وجهاز\r\nمستلم الرسالة فقط ا￾￾ط￾￾ع على\nالمعلومات\r\n \\ .المتبادلة في الرسالة\r\n :المصادر ذات الصلة\r\n | Android: كيفية إعادة توجيه الرسائل عبر\r\n KaiOS |\nواتساب للويب وللكمبيوتر | iPhone\r\nتعرف على المزيد حول كيفية مكافحة واتساب"
/// facebook : "Facebook"
/// whatsapp : "Whatsapp"
/// instagram : "Instagram"
/// youtube : "youtube"
/// twitter : "Twitter"

AboutApp aboutAppFromJson(String str) => AboutApp.fromJson(json.decode(str));

String aboutAppToJson(AboutApp data) => json.encode(data.toJson());

class AboutApp {
  AboutApp({
    String? title,
    String? text,
    String? facebook,
    String? whatsapp,
    String? instagram,
    String? youtube,
    String? twitter,
  }) {
    _title = title;
    _text = text;
    _facebook = facebook;
    _whatsapp = whatsapp;
    _instagram = instagram;
    _youtube = youtube;
    _twitter = twitter;
  }

  AboutApp.fromJson(dynamic json) {
    _title = json['title'];
    _text = json['text'];
    _facebook = json['facebook'];
    _whatsapp = json['whatsapp'];
    _instagram = json['instagram'];
    _youtube = json['youtube'];
    _twitter = json['twitter'];
  }

  String? _title;
  String? _text;
  String? _facebook;
  String? _whatsapp;
  String? _instagram;
  String? _youtube;
  String? _twitter;

  AboutApp copyWith({
    String? title,
    String? text,
    String? facebook,
    String? whatsapp,
    String? instagram,
    String? youtube,
    String? twitter,
  }) =>
      AboutApp(
        title: title ?? _title,
        text: text ?? _text,
        facebook: facebook ?? _facebook,
        whatsapp: whatsapp ?? _whatsapp,
        instagram: instagram ?? _instagram,
        youtube: youtube ?? _youtube,
        twitter: twitter ?? _twitter,
      );

  String? get title => _title;

  String? get text => _text;

  String? get facebook => _facebook;

  String? get whatsapp => _whatsapp;

  String? get instagram => _instagram;

  String? get youtube => _youtube;

  String? get twitter => _twitter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['text'] = _text;
    map['facebook'] = _facebook;
    map['whatsapp'] = _whatsapp;
    map['instagram'] = _instagram;
    map['youtube'] = _youtube;
    map['twitter'] = _twitter;
    return map;
  }
}
