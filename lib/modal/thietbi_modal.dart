import 'thietbi_phong_modal.dart';

class Thietbis {
  int? id;
  String? ten;
  String? hinh;
  int? gia;
  String? mieuTa;
  Null? phongid;
  String? createdAt;
  String? updatedAt;
  ThietbiPhong? pivot;

  Thietbis(
      {this.id,
      this.ten,
      this.hinh,
      this.gia,
      this.mieuTa,
      this.phongid,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Thietbis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    hinh = json['hinh'];
    gia = json['gia'];
    mieuTa = json['mieuTa'];
    phongid = json['phongid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new ThietbiPhong.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['hinh'] = this.hinh;
    data['gia'] = this.gia;
    data['mieuTa'] = this.mieuTa;
    data['phongid'] = this.phongid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}
