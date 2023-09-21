class GiuongPhong {
  int? phongid;
  int? giuongid;

  GiuongPhong({this.phongid, this.giuongid});

  GiuongPhong.fromJson(Map<String, dynamic> json) {
    phongid = json['phongid'];
    giuongid = json['giuongid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phongid'] = this.phongid;
    data['giuongid'] = this.giuongid;
    return data;
  }
}
