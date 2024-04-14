import 'wait_confirmation.dart';

class WaitConfirmationModel {
  List<WaitConfirmation>? waitConfirmation;
  String? status;

  WaitConfirmationModel({this.waitConfirmation, this.status});

  WaitConfirmationModel.fromJson(Map<String, dynamic> json) {
    if (json['wait_confirmation'] != null) {
      waitConfirmation = <WaitConfirmation>[];
      json['wait_confirmation'].forEach((v) {
        waitConfirmation!.add(new WaitConfirmation.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.waitConfirmation != null) {
      data['wait_confirmation'] =
          this.waitConfirmation!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
