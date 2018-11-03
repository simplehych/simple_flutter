import 'package:json_annotation/json_annotation.dart';

part 'wx_public_account_article.g.dart';


@JsonSerializable()
class WxPublicAccountArticle extends Object {

  @JsonKey(name: 'curPage')
  int curPage;

  @JsonKey(name: 'datas')
  List<Data> datas;

  @JsonKey(name: 'offset')
  int offset;

  @JsonKey(name: 'over')
  bool over;

  @JsonKey(name: 'pageCount')
  int pageCount;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'total')
  int total;

  WxPublicAccountArticle(this.curPage,this.datas,this.offset,this.over,this.pageCount,this.size,this.total,);

  factory WxPublicAccountArticle.fromJson(Map<String, dynamic> srcJson) => _$WxPublicAccountArticleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WxPublicAccountArticleToJson(this);

  @override
  String toString() {
    return 'WxPublicAccountArticle{curPage: $curPage, datas: $datas, offset: $offset, over: $over, pageCount: $pageCount, size: $size, total: $total}';
  }


}


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: 'apkLink')
  String apkLink;

  @JsonKey(name: 'author')
  String author;

  @JsonKey(name: 'chapterId')
  int chapterId;

  @JsonKey(name: 'chapterName')
  String chapterName;

  @JsonKey(name: 'collect')
  bool collect;

  @JsonKey(name: 'courseId')
  int courseId;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'envelopePic')
  String envelopePic;

  @JsonKey(name: 'fresh')
  bool fresh;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'niceDate')
  String niceDate;

  @JsonKey(name: 'origin')
  String origin;

  @JsonKey(name: 'projectLink')
  String projectLink;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'superChapterId')
  int superChapterId;

  @JsonKey(name: 'superChapterName')
  String superChapterName;

  @JsonKey(name: 'tags')
  List<Tag> tags;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'visible')
  int visible;

  @JsonKey(name: 'zan')
  int zan;

  Data(this.apkLink,this.author,this.chapterId,this.chapterName,this.collect,this.courseId,this.desc,this.envelopePic,this.fresh,this.id,this.link,this.niceDate,this.origin,this.projectLink,this.publishTime,this.superChapterId,this.superChapterName,this.tags,this.title,this.type,this.userId,this.visible,this.zan,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DatasFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DatasToJson(this);




}


@JsonSerializable()
class Tag extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'url')
  String url;

  Tag(this.name,this.url,);

  factory Tag.fromJson(Map<String, dynamic> srcJson) => _$TagsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagsToJson(this);

}