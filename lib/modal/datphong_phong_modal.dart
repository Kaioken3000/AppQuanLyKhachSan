class DatphongPhong {
  int? datphongid;
  int? phongid;

  DatphongPhong({this.datphongid, this.phongid});

  DatphongPhong.fromJson(Map<String, dynamic> json) {
    datphongid = json['datphongid'];
    phongid = json['phongid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datphongid'] = this.datphongid;
    data['phongid'] = this.phongid;
    return data;
  }
}