import 'package:json_annotation/json_annotation.dart';

part 'wx_public_account.g.dart';

@JsonSerializable()
class WxPublicAccount {
  List<String> children;

  int courseId;

  int id;

  String name;

  int order;

  int parentChapterId;

  bool userControlSetTop;

  int visible;

  WxPublicAccount(
    //    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  );

  factory WxPublicAccount.fromJson(Map<String, dynamic> srcJson) =>
      _$WxPublicAccountFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WxPublicAccountToJson(this);

  @override
  String toString() {
    return 'WxPublicAccount{courseId: $courseId, id: $id, name: $name, order: $order, parentChapterId: $parentChapterId, userControlSetTop: $userControlSetTop, visible: $visible}';
  }
}
