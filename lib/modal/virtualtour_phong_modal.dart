class Virtualtourphongs {
  int? id;
  int? phongid;
  int? virtualtourid;
  String? createdAt;
  String? updatedAt;

  Virtualtourphongs(
      {this.id,
      this.phongid,
      this.virtualtourid,
      this.createdAt,
      this.updatedAt});

  Virtualtourphongs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phongid = json['phongid'];
    virtualtourid = json['virtualtourid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phongid'] = this.phongid;
    data['virtualtourid'] = this.virtualtourid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}