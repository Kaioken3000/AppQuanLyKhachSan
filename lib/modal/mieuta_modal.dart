import 'mieuta_phong_modal.dart';

class Mieutas {
  int? id;
  String? noidung;
  String? hinh;
  Null? phongid;
  String? createdAt;
  String? updatedAt;
  MieutaPhong? pivot;

  Mieutas(
      {this.id,
      this.noidung,
      this.hinh,
      this.phongid,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Mieutas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noidung = json['noidung'];
    hinh = json['hinh'];
    phongid = json['phongid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new MieutaPhong.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['noidung'] = this.noidung;
    data['hinh'] = this.hinh;
    data['phongid'] = this.phongid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}
