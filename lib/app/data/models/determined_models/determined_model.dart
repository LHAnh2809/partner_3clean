import 'determined.dart';

class DeterminedModel {
  List<Determined>? determined;
  String? status;

  DeterminedModel({this.determined, this.status});

  DeterminedModel.fromJson(Map<String, dynamic> json) {
    if (json['get_determined'] != null) {
      determined = <Determined>[];
      json['get_determined'].forEach((v) {
        determined!.add(new Determined.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.determined != null) {
      data['get_determined'] = this.determined!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
