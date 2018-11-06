import 'package:json_annotation/json_annotation.dart';

part 'home_banner_bean.g.dart';

@JsonSerializable()
class HomeBannerBean extends Object {
  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'imagePath')
  String imagePath;

  @JsonKey(name: 'isVisible')
  int isVisible;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'url')
  String url;

  HomeBannerBean(
    this.desc,
    this.id,
    this.imagePath,
    this.isVisible,
    this.order,
    this.title,
    this.type,
    this.url,
  );

  factory HomeBannerBean.fromJson(Map<String, dynamic> srcJson) =>
      _$HomeBannerBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeBannerBeanToJson(this);
}
