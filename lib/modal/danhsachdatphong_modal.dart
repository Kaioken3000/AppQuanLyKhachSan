class Danhsachdatphongs {
  int? id;
  int? datphongid;
  int? phongid;
  String? ngaybatdauo;
  String? ngayketthuco;
  String? createdAt;
  String? updatedAt;

  Danhsachdatphongs(
      {this.id,
      this.datphongid,
      this.phongid,
      this.ngaybatdauo,
      this.ngayketthuco,
      this.createdAt,
      this.updatedAt});

  Danhsachdatphongs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    datphongid = json['datphongid'];
    phongid = json['phongid'];
    ngaybatdauo = json['ngaybatdauo'];
    ngayketthuco = json['ngayketthuco'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['datphongid'] = this.datphongid;
    data['phongid'] = this.phongid;
    data['ngaybatdauo'] = this.ngaybatdauo;
    data['ngayketthuco'] = this.ngayketthuco;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
