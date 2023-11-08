import 'virtualtour_phong_modal.dart';

class Virtualtour {
  int? id;
  String? hinh;
  Null? phongid;
  String? createdAt;
  String? updatedAt;
  List<Virtualtourphongs>? virtualtourphongs;

  Virtualtour(
      {this.id,
      this.hinh,
      this.phongid,
      this.createdAt,
      this.updatedAt,
      this.virtualtourphongs});

  Virtualtour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hinh = json['hinh'];
    phongid = json['phongid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['virtualtourphongs'] != null) {
      virtualtourphongs = <Virtualtourphongs>[];
      json['virtualtourphongs'].forEach((v) {
        virtualtourphongs!.add(new Virtualtourphongs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hinh'] = this.hinh;
    data['phongid'] = this.phongid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.virtualtourphongs != null) {
      data['virtualtourphongs'] =
          this.virtualtourphongs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}