class Chinhanhs {
  int? id;
  String? ten;
  int? soluong;
  String? thanhpho;
  String? quan;
  String? sdt;
  String? createdAt;
  String? updatedAt;

  @override
  bool operator ==(Object other) => other is Chinhanhs && other.id == id;

  @override
  int get hashCode => id.hashCode;

  Chinhanhs(
      {this.id,
      this.ten,
      this.soluong,
      this.thanhpho,
      this.quan,
      this.sdt,
      this.createdAt,
      this.updatedAt});

  Chinhanhs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    soluong = json['soluong'];
    thanhpho = json['thanhpho'];
    quan = json['quan'];
    sdt = json['sdt'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['soluong'] = this.soluong;
    data['thanhpho'] = this.thanhpho;
    data['quan'] = this.quan;
    data['sdt'] = this.sdt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
