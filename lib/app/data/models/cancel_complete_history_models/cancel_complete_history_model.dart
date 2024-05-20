import 'cancel_complete_history.dart';

class CancelCompleteHistoryModel {
  List<CancelCompleteHistory>? cancelCompleteHistory;
  String? status;

  CancelCompleteHistoryModel({this.cancelCompleteHistory, this.status});

  CancelCompleteHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['cancel_complete_history'] != null) {
      cancelCompleteHistory = <CancelCompleteHistory>[];
      json['cancel_complete_history'].forEach((v) {
        cancelCompleteHistory!.add(new CancelCompleteHistory.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cancelCompleteHistory != null) {
      data['cancel_complete_history'] =
          this.cancelCompleteHistory!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
