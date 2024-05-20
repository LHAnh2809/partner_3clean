class Statistics {
  int? vcdl;
  int? price;
  int? blt;
  int? blx;

  Statistics({this.vcdl, this.price, this.blt, this.blx});

  Statistics.fromJson(Map<String, dynamic> json) {
    vcdl = json['vcdl'];
    price = json['price'];
    blt = json['blt'];
    blx = json['blx'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vcdl'] = this.vcdl;
    data['price'] = this.price;
    data['blt'] = this.blt;
    data['blx'] = this.blx;
    return data;
  }
}