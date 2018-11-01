// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wx_public_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WxPublicAccount _$WxPublicAccountFromJson(Map<String, dynamic> json) {
  return WxPublicAccount(
      json['courseId'] as int,
      json['id'] as int,
      json['name'] as String,
      json['order'] as int,
      json['parentChapterId'] as int,
      json['userControlSetTop'] as bool,
      json['visible'] as int)
    ..children = (json['children'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$WxPublicAccountToJson(WxPublicAccount instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible
    };
