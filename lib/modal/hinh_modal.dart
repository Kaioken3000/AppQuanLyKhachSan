import 'hinh_phong_modal.dart';

class Hinhs {
  int? id;
  String? vitri;
  Null? phongid;
  String? createdAt;
  String? updatedAt;
  HinhPhong? pivot;

  Hinhs(
      {this.id,
      this.vitri,
      this.phongid,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Hinhs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vitri = json['vitri'];
    phongid = json['phongid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new HinhPhong.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vitri'] = this.vitri;
    data['phongid'] = this.phongid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}
