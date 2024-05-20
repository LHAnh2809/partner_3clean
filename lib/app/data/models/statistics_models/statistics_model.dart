import 'statistics.dart';

class StatisticsModel {
  List<Statistics>? statistics;

  StatisticsModel({this.statistics});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    if (json['statistics'] != null) {
      statistics = <Statistics>[];
      json['statistics'].forEach((v) {
        statistics!.add(new Statistics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
