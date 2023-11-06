class DichvuDatphong {
  int? datphongid;
  int? dichvuid;

  DichvuDatphong({this.datphongid, this.dichvuid});

  DichvuDatphong.fromJson(Map<String, dynamic> json) {
    datphongid = json['datphongid'];
    dichvuid = json['dichvuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datphongid'] = this.datphongid;
    data['dichvuid'] = this.dichvuid;
    return data;
  }
}
