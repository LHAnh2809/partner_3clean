import 'calendar.dart';

class CalendarModel {
  List<Calendar>? calendar;
  String? status;

  CalendarModel({this.calendar, this.status});

  CalendarModel.fromJson(Map<String, dynamic> json) {
    if (json['calendar'] != null) {
      calendar = <Calendar>[];
      json['calendar'].forEach((v) {
        calendar!.add(new Calendar.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.calendar != null) {
      data['calendar'] = this.calendar!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
