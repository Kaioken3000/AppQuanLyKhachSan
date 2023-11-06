import 'anuong_datphong.dart';

class Anuongs {
  int? id;
  String? ten;
  String? hinh;
  int? gia;
  int? soluong;
  String? mieuTa;
  String? createdAt;
  String? updatedAt;
  int? chinhanhid;
  int? diem;
  AnuongDatphong? pivot;

  Anuongs(
      {this.id,
      this.ten,
      this.hinh,
      this.gia,
      this.soluong,
      this.mieuTa,
      this.createdAt,
      this.updatedAt,
      this.chinhanhid,
      this.diem,
      this.pivot});

  Anuongs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    hinh = json['hinh'];
    gia = json['gia'];
    soluong = json['soluong'];
    mieuTa = json['mieuTa'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    chinhanhid = json['chinhanhid'];
    diem = json['diem'];
    pivot = json['pivot'] != null
        ? new AnuongDatphong.fromJson(json['pivot'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['hinh'] = this.hinh;
    data['gia'] = this.gia;
    data['soluong'] = this.soluong;
    data['mieuTa'] = this.mieuTa;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['chinhanhid'] = this.chinhanhid;
    data['diem'] = this.diem;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}
