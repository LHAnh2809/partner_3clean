class CancelCompleteHistory {
  String? location;
  String? location2;
  String? workTime;
  int? label;
  String? workingDay;
  String? cancelJob;
  String? reasonCancellation;
  String? cancellationIimeCompleted;
  int? orderStatus;

  CancelCompleteHistory(
      {this.location,
      this.location2,
      this.workTime,
      this.label,
      this.workingDay,
      this.cancelJob,
      this.reasonCancellation,
      this.cancellationIimeCompleted,
      this.orderStatus});

  CancelCompleteHistory.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    location2 = json['location2'];
    label = json['label'];
    workTime = json['work_time'];
    workingDay = json['workingDay'];
    cancelJob = json['cancelJob'];
    reasonCancellation = json['reasonCancellation'];
    cancellationIimeCompleted = json['cancellationIimeCompleted'];
    orderStatus = json['orderStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['location2'] = this.location2;
    data['work_time'] = this.workTime;
    data['label'] = this.label;
    data['workingDay'] = this.workingDay;
    data['cancelJob'] = this.cancelJob;
    data['reasonCancellation'] = this.reasonCancellation;
    data['cancellationIimeCompleted'] = this.cancellationIimeCompleted;
    data['orderStatus'] = this.orderStatus;
    return data;
  }
}
