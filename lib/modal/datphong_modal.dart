import 'anuong_modal.dart';
import 'dichvu_modal.dart';
import 'phong_modal.dart';
import 'thanhtoan_modal.dart';

class Datphongs {
  int? id;
  String? ngaydat;
  String? ngaytra;
  int? soluong;
  int? khachhangid;
  int? tinhtrangthanhtoan;
  int? tinhtrangnhanphong;
  int? tinhtrangxuly;
  String? createdAt;
  String? updatedAt;
  int? huydatphong;
  List<Phongs>? phongs;
  List<Dichvus>? dichvus;
  List<Anuongs>? anuongs;
  List<Thanhtoans>? thanhtoans;

  Datphongs(
      {this.id,
      this.ngaydat,
      this.ngaytra,
      this.soluong,
      this.khachhangid,
      this.tinhtrangthanhtoan,
      this.tinhtrangnhanphong,
      this.tinhtrangxuly,
      this.createdAt,
      this.updatedAt,
      this.huydatphong,
      this.phongs,
      this.dichvus,
      this.anuongs,
      this.thanhtoans});

  Datphongs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ngaydat = json['ngaydat'];
    ngaytra = json['ngaytra'];
    soluong = json['soluong'];
    khachhangid = json['khachhangid'];
    tinhtrangthanhtoan = json['tinhtrangthanhtoan'];
    tinhtrangnhanphong = json['tinhtrangnhanphong'];
    tinhtrangxuly = json['tinhtrangxuly'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    huydatphong = json['huydatphong'];
    if (json['phongs'] != null) {
      phongs = <Phongs>[];
      json['phongs'].forEach((v) {
        phongs!.add(new Phongs.fromJson(v));
      });
    }
    if (json['dichvus'] != null) {
      dichvus = <Dichvus>[];
      json['dichvus'].forEach((v) {
        dichvus!.add(new Dichvus.fromJson(v));
      });
    }
    if (json['anuongs'] != null) {
      anuongs = <Anuongs>[];
      json['anuongs'].forEach((v) {
        anuongs!.add(new Anuongs.fromJson(v));
      });
    }
    if (json['thanhtoans'] != null) {
      thanhtoans = <Thanhtoans>[];
      json['thanhtoans'].forEach((v) {
        thanhtoans!.add(new Thanhtoans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ngaydat'] = this.ngaydat;
    data['ngaytra'] = this.ngaytra;
    data['soluong'] = this.soluong;
    data['khachhangid'] = this.khachhangid;
    data['tinhtrangthanhtoan'] = this.tinhtrangthanhtoan;
    data['tinhtrangnhanphong'] = this.tinhtrangnhanphong;
    data['tinhtrangxuly'] = this.tinhtrangxuly;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['huydatphong'] = this.huydatphong;
    if (this.phongs != null) {
      data['phongs'] = this.phongs!.map((v) => v.toJson()).toList();
    }
    if (this.dichvus != null) {
      data['dichvus'] = this.dichvus!.map((v) => v.toJson()).toList();
    }
    if (this.anuongs != null) {
      data['anuongs'] = this.anuongs!.map((v) => v.toJson()).toList();
    }
    if (this.thanhtoans != null) {
      data['thanhtoans'] = this.thanhtoans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
