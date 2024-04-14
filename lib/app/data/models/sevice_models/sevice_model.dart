import 'sevice.dart';

class ServiceModel {
  List<Service>? service;
  String? status;

  ServiceModel({this.service, this.status});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add(new Service.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
