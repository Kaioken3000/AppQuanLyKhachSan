class AnuongDatphong {
  int? datphongid;
  int? anuongid;
  int? soluong;

  AnuongDatphong({this.datphongid, this.anuongid, this.soluong});

  AnuongDatphong.fromJson(Map<String, dynamic> json) {
    datphongid = json['datphongid'];
    anuongid = json['anuongid'];
    soluong = json['soluong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datphongid'] = this.datphongid;
    data['anuongid'] = this.anuongid;
    data['soluong'] = this.soluong;
    return data;
  }
}
