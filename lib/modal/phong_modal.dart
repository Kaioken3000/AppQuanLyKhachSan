import 'giuong_modal.dart';
import 'thietbi_modal.dart';
import 'loaiphong_modal.dart';
import 'hinh_modal.dart';
import 'mieuta_modal.dart';
import 'chinhanh_modal.dart';

class Phongs {
  int? soPhong;
  String? loaiphongid;
  String? createdAt;
  String? updatedAt;
  String? picture1;
  String? picture2;
  String? picture3;
  int? chinhanhid;
  List<Giuongs>? giuongs;
  List<Thietbis>? thietbis;
  Loaiphongs? loaiphongs;
  List<Hinhs>? hinhs;
  List<Mieutas>? mieutas;
  Chinhanhs? chinhanhs;

  Phongs(
      {this.soPhong,
      this.loaiphongid,
      this.createdAt,
      this.updatedAt,
      this.picture1,
      this.picture2,
      this.picture3,
      this.chinhanhid,
      this.giuongs,
      this.thietbis,
      this.loaiphongs,
      this.hinhs,
      this.mieutas,
      this.chinhanhs});

  Phongs.fromJson(Map<String, dynamic> json) {
    soPhong = json['so_phong'];
    loaiphongid = json['loaiphongid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    picture1 = json['picture_1'];
    picture2 = json['picture_2'];
    picture3 = json['picture_3'];
    chinhanhid = json['chinhanhid'];
    if (json['giuongs'] != null) {
      giuongs = <Giuongs>[];
      json['giuongs'].forEach((v) {
        giuongs!.add(new Giuongs.fromJson(v));
      });
    }
    if (json['thietbis'] != null) {
      thietbis = <Thietbis>[];
      json['thietbis'].forEach((v) {
        thietbis!.add(new Thietbis.fromJson(v));
      });
    }
    loaiphongs = json['loaiphongs'] != null
        ? new Loaiphongs.fromJson(json['loaiphongs'])
        : null;
    if (json['hinhs'] != null) {
      hinhs = <Hinhs>[];
      json['hinhs'].forEach((v) {
        hinhs!.add(new Hinhs.fromJson(v));
      });
    }
    if (json['mieutas'] != null) {
      mieutas = <Mieutas>[];
      json['mieutas'].forEach((v) {
        mieutas!.add(new Mieutas.fromJson(v));
      });
    }
    chinhanhs = json['chinhanhs'] != null
        ? new Chinhanhs.fromJson(json['chinhanhs'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['so_phong'] = this.soPhong;
    data['loaiphongid'] = this.loaiphongid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['picture_1'] = this.picture1;
    data['picture_2'] = this.picture2;
    data['picture_3'] = this.picture3;
    data['chinhanhid'] = this.chinhanhid;
    if (this.giuongs != null) {
      data['giuongs'] = this.giuongs!.map((v) => v.toJson()).toList();
    }
    if (this.thietbis != null) {
      data['thietbis'] = this.thietbis!.map((v) => v.toJson()).toList();
    }
    if (this.loaiphongs != null) {
      data['loaiphongs'] = this.loaiphongs!.toJson();
    }
    if (this.hinhs != null) {
      data['hinhs'] = this.hinhs!.map((v) => v.toJson()).toList();
    }
    if (this.mieutas != null) {
      data['mieutas'] = this.mieutas!.map((v) => v.toJson()).toList();
    }
    if (this.chinhanhs != null) {
      data['chinhanhs'] = this.chinhanhs!.toJson();
    }
    return data;
  }
}
