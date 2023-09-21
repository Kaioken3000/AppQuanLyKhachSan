class ThietbiPhong {
  int? phongid;
  int? thietbiid;

  ThietbiPhong({this.phongid, this.thietbiid});

  ThietbiPhong.fromJson(Map<String, dynamic> json) {
    phongid = json['phongid'];
    thietbiid = json['thietbiid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phongid'] = this.phongid;
    data['thietbiid'] = this.thietbiid;
    return data;
  }
}
