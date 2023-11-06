import 'dichvu_datphong.dart';

class Dichvus2 {
  int? id;
  String? ten;
  int? giatien;
  String? donvi;
  String? createdAt;
  String? updatedAt;
  int? chinhanhid;
  int? diem;

  Dichvus2(
      {this.id,
      this.ten,
      this.giatien,
      this.donvi,
      this.createdAt,
      this.updatedAt,
      this.chinhanhid,
      this.diem,});

  Dichvus2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    giatien = json['giatien'];
    donvi = json['donvi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    chinhanhid = json['chinhanhid'];
    diem = json['diem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['giatien'] = this.giatien;
    data['donvi'] = this.donvi;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['chinhanhid'] = this.chinhanhid;
    data['diem'] = this.diem;
    return data;
  }
}
