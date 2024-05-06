
import 'wallel.dart';

class CleanWallet {
  int? moneyP;
  List<Wallet>? wallet;

  CleanWallet({this.moneyP, this.wallet});

  CleanWallet.fromJson(Map<String, dynamic> json) {
    moneyP = json['moneyP'];
    if (json['wallet'] != null) {
      wallet = <Wallet>[];
      json['wallet'].forEach((v) {
        wallet!.add(new Wallet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moneyP'] = this.moneyP;
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}