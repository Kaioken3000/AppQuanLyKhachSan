class Khachhangs {
  int? id;
  String? ten;
  int? sdt;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? datphongid;
  int? userid;
  String? diachi;
  String? gioitinh;
  String? vanbang;
  int? diem;

  Khachhangs(
      {this.id,
      this.ten,
      this.sdt,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.datphongid,
      this.userid,
      this.diachi,
      this.gioitinh,
      this.vanbang,
      this.diem});

  Khachhangs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    sdt = json['sdt'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    datphongid = json['datphongid'];
    userid = json['userid'];
    diachi = json['diachi'];
    gioitinh = json['gioitinh'];
    vanbang = json['vanbang'];
    diem = json['diem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['sdt'] = this.sdt;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['datphongid'] = this.datphongid;
    data['userid'] = this.userid;
    data['diachi'] = this.diachi;
    data['gioitinh'] = this.gioitinh;
    data['vanbang'] = this.vanbang;
    data['diem'] = this.diem;
    return data;
  }
}
