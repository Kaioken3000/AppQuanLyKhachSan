class HinhPhong {
  int? phongid;
  int? hinhid;

  HinhPhong({this.phongid, this.hinhid});

  HinhPhong.fromJson(Map<String, dynamic> json) {
    phongid = json['phongid'];
    hinhid = json['hinhid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phongid'] = this.phongid;
    data['hinhid'] = this.hinhid;
    return data;
  }
}
