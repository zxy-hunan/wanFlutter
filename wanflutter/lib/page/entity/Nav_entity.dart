import 'article_entity.dart';

class NaviEntity {
  List<NaviData>? data;
  int? errorCode;
  String? errorMsg;

  NaviEntity({this.data, this.errorCode, this.errorMsg});

  NaviEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <dynamic>[].cast<NaviData>();
      (json['data'] as List).forEach((v) {
        data!.add(new NaviData.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class NaviData {
  String? name;
  List<ArticleDataData>? articles;
  int? cid;

  NaviData({this.name, this.articles, this.cid});

  NaviData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['articles'] != null) {
      articles = <dynamic>[].cast<ArticleDataData>();
      (json['articles'] as List).forEach((v) {
        articles!.add(new ArticleDataData.fromJson(v));
      });
    }
    cid = json['cid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    data['cid'] = this.cid;
    return data;
  }
}
