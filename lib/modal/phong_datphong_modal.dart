class PhongDatphong {
  int? datphongid;
  int? phongid;
  String? ngaybatdauo;
  String? ngayketthuco;

  PhongDatphong(
      {this.datphongid, this.phongid, this.ngaybatdauo, this.ngayketthuco});

  PhongDatphong.fromJson(Map<String, dynamic> json) {
    datphongid = json['datphongid'];
    phongid = json['phongid'];
    ngaybatdauo = json['ngaybatdauo'];
    ngayketthuco = json['ngayketthuco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datphongid'] = this.datphongid;
    data['phongid'] = this.phongid;
    data['ngaybatdauo'] = this.ngaybatdauo;
    data['ngayketthuco'] = this.ngayketthuco;
    return data;
  }
}
