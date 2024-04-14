import 'job_all.dart';

class JobAllModel {
  List<JobAll>? jobAll;
  String? status;

  JobAllModel({this.jobAll, this.status});

  JobAllModel.fromJson(Map<String, dynamic> json) {
    if (json['job_all'] != null) {
      jobAll = <JobAll>[];
      json['job_all'].forEach((v) {
        jobAll!.add(new JobAll.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobAll != null) {
      data['job_all'] = this.jobAll!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
