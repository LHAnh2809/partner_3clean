import 'package:partner_3clean/app/common/util/extension/index.dart';

class PhongChat {
  String? idTVC;
  String? idU;
  String? image;
  String? nameU;
  String? idPC;
  String? phoneNumber;
  int? daDoc;
  String? tinNhanCuoiCung;
  String? tGNT;
  String? tGTP;

  PhongChat(
      {this.idTVC,
      this.idU,
      this.image,
      this.nameU,
      this.idPC,
      this.phoneNumber,
      this.daDoc,
      this.tinNhanCuoiCung,
      this.tGNT,
      this.tGTP});

  PhongChat.fromJson(Map<String, dynamic> json) {
    idTVC = json['idTVC'];
    nameU = json['nameU'];
    idU = json['idU'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];
    idPC = json['idPC'];
    daDoc = json['da_doc'];
    tinNhanCuoiCung = json['tin_nhan_cuoi_cung'];
    tGNT = json['TGNT'];
    tGTP = json['TGTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTVC'] = this.idTVC;
    data['idU'] = this.idU;
    data['nameU'] = this.nameU;
    data['phoneNumber'] = this.phoneNumber;
    data['image'] = this.image;
    data['idPC'] = this.idPC;
    data['da_doc'] = this.daDoc;
    data['tin_nhan_cuoi_cung'] = this.tinNhanCuoiCung;
    data['TGNT'] = this.tGNT;
    data['TGTP'] = this.tGTP;
    return data;
  }
}
