import 'khachhang_modal.dart';

class Users {
  int? id;
  Null? name;
  String? email;
  String? username;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? sdt;
  Null? stripeId;
  Null? pmType;
  Null? pmLastFour;
  Null? trialEndsAt;
  Null? googleId;
  Null? facebookId;
  int? activeStatus;
  String? avatar;
  int? darkMode;
  Null? messengerColor;
  String? diachi;
  String? gioitinh;
  String? vanbang;
  List<Khachhangs>? khachhangs;

  Users(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.sdt,
      this.stripeId,
      this.pmType,
      this.pmLastFour,
      this.trialEndsAt,
      this.googleId,
      this.facebookId,
      this.activeStatus,
      this.avatar,
      this.darkMode,
      this.messengerColor,
      this.diachi,
      this.gioitinh,
      this.vanbang,
      this.khachhangs});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sdt = json['sdt'];
    stripeId = json['stripe_id'];
    pmType = json['pm_type'];
    pmLastFour = json['pm_last_four'];
    trialEndsAt = json['trial_ends_at'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    activeStatus = json['active_status'];
    avatar = json['avatar'];
    darkMode = json['dark_mode'];
    messengerColor = json['messenger_color'];
    diachi = json['diachi'];
    gioitinh = json['gioitinh'];
    vanbang = json['vanbang'];
    if (json['khachhangs'] != null) {
      khachhangs = <Khachhangs>[];
      json['khachhangs'].forEach((v) {
        khachhangs!.add(new Khachhangs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(r) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['sdt'] = this.sdt;
    data['stripe_id'] = this.stripeId;
    data['pm_type'] = this.pmType;
    data['pm_last_four'] = this.pmLastFour;
    data['trial_ends_at'] = this.trialEndsAt;
    data['google_id'] = this.googleId;
    data['facebook_id'] = this.facebookId;
    data['active_status'] = this.activeStatus;
    data['avatar'] = this.avatar;
    data['dark_mode'] = this.darkMode;
    data['messenger_color'] = this.messengerColor;
    data['diachi'] = this.diachi;
    data['gioitinh'] = this.gioitinh;
    data['vanbang'] = this.vanbang;
    if (this.khachhangs != null) {
      data['khachhangs'] = this.khachhangs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
