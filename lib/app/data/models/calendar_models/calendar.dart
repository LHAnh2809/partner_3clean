import 'jobs.dart';

class Calendar {
  String? firstDay;
  String? day;
  int? jobSalary;
  List<Jobs>? jobs;

  Calendar({this.firstDay, this.day, this.jobSalary, this.jobs});

  Calendar.fromJson(Map<String, dynamic> json) {
    firstDay = json['firstDay'];
    day = json['Day'];
    jobSalary = json['jobSalary'];
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstDay'] = this.firstDay;
    data['Day'] = this.day;
    data['jobSalary'] = this.jobSalary;
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}