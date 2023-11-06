import 'user_modal.dart';

class Comments {
  int? id;
  String? noidung;
  int? phongid;
  int? userid;
  String? createdAt;
  String? updatedAt;
  Users? users;

  Comments(
      {this.id,
      this.noidung,
      this.phongid,
      this.userid,
      this.createdAt,
      this.updatedAt,
      this.users});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noidung = json['noidung'];
    phongid = json['phongid'];
    userid = json['userid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['noidung'] = this.noidung;
    data['phongid'] = this.phongid;
    data['userid'] = this.userid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}
