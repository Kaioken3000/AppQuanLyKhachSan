class Thanhtoans {
  int? id;
  String? hinhthuc;
  int? gia;
  String? chuyenkhoanToken;
  String? createdAt;
  String? updatedAt;
  String? loaitien;
  int? datphongid;

  Thanhtoans(
      {this.id,
      this.hinhthuc,
      this.gia,
      this.chuyenkhoanToken,
      this.createdAt,
      this.updatedAt,
      this.loaitien,
      this.datphongid});

  Thanhtoans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hinhthuc = json['hinhthuc'];
    gia = json['gia'];
    chuyenkhoanToken = json['chuyenkhoan_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    loaitien = json['loaitien'];
    datphongid = json['datphongid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hinhthuc'] = this.hinhthuc;
    data['gia'] = this.gia;
    data['chuyenkhoan_token'] = this.chuyenkhoanToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['loaitien'] = this.loaitien;
    data['datphongid'] = this.datphongid;
    return data;
  }
}
