class BannerEntity {
  List<BannerData>? data;
  int? errorCode;
  String? errorMsg;

  BannerEntity({this.data, this.errorCode, this.errorMsg});

  BannerEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <dynamic>[].cast<BannerData>();
      (json['data'] as List).forEach((element) {
        data!.add(new BannerData.fromJson(element));
      });
    }
  }
}

class BannerData {
  String imagePath = '2';
  int? id;
  int? isVisible;
  String? title;
  int? type;
  String? url;
  String? desc;
  int? order;

  BannerData(
      {this.imagePath = '2',
      this.id,
      this.isVisible,
      this.title,
      this.type,
      this.url,
      this.desc,
      this.order});

  BannerData.fromJson(Map<String, dynamic> json) {
    imagePath = json['imagePath'];
    id = json['id'];
    isVisible = json['isVisible'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    desc = json['desc'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagePath'] = this.imagePath;
    data['id'] = this.id;
    data['isVisible'] = this.isVisible;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['desc'] = this.desc;
    data['order'] = this.order;
    return data;
  }
}
