class MieutaPhong {
  int? phongid;
  int? mieutaid;

  MieutaPhong({this.phongid, this.mieutaid});

  MieutaPhong.fromJson(Map<String, dynamic> json) {
    phongid = json['phongid'];
    mieutaid = json['mieutaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phongid'] = this.phongid;
    data['mieutaid'] = this.mieutaid;
    return data;
  }
}
