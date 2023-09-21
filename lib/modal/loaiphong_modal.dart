class Loaiphongs {
  String? ma;
  String? ten;
  int? gia;
  String? hinh;
  int? soluong;
  String? mieuTa;
  String? createdAt;
  String? updatedAt;

  Loaiphongs(
      {this.ma,
      this.ten,
      this.gia,
      this.hinh,
      this.soluong,
      this.mieuTa,
      this.createdAt,
      this.updatedAt});

  Loaiphongs.fromJson(Map<String, dynamic> json) {
    ma = json['ma'];
    ten = json['ten'];
    gia = json['gia'];
    hinh = json['hinh'];
    soluong = json['soluong'];
    mieuTa = json['mieuTa'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ma'] = this.ma;
    data['ten'] = this.ten;
    data['gia'] = this.gia;
    data['hinh'] = this.hinh;
    data['soluong'] = this.soluong;
    data['mieuTa'] = this.mieuTa;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
