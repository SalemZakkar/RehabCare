/// image_id : null
/// url : "http://dashboard.aboutcare.net/assets/images/image_slider/image_slidr_8614585.jpg"

class BannerModel {
  BannerModel({
    dynamic imageId,
    String? url,
  }) {
    _imageId = imageId;
    _url = url;
  }

  BannerModel.fromJson(dynamic json) {
    _imageId = json['image_id'];
    _url = json['url'];
  }

  dynamic _imageId;
  String? _url;

  BannerModel copyWith({
    dynamic imageId,
    String? url,
  }) =>
      BannerModel(
        imageId: imageId ?? _imageId,
        url: url ?? _url,
      );

  dynamic get imageId => _imageId;

  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_id'] = _imageId;
    map['url'] = _url;
    return map;
  }
}
