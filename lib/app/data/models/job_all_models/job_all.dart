class JobAll {
  String? id;
  String? lat;
  String? lng;
  String? location;
  int? repeatState;
  String? numberSessions;
  String? duration;
  String? repeat;
  String? location2;
  String? workTime;
  String? petNotes;
  int? label;
  String? employeeNotes;
  String? roomArea;
  int? premiumService;
  int? paymentMethods;
  int? orderStatus;
  String? workingDay;
  int? price;
  int? acceptJobCount;

  JobAll(
      {this.id,
      this.lat,
      this.lng,
      this.location,
      this.repeatState,
      this.numberSessions,
      this.duration,
      this.repeat,
      this.location2,
      this.workTime,
      this.petNotes,
      this.label,
      this.employeeNotes,
      this.roomArea,
      this.premiumService,
      this.paymentMethods,
      this.orderStatus,
      this.workingDay,
      this.price,
      this.acceptJobCount});

  JobAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
    repeatState = json['repeatState'];
    numberSessions = json['numberSessions'];
    duration = json['duration'];
    repeat = json['repeat'];
    location2 = json['location2'];
    workTime = json['work_time'];
    petNotes = json['pet_notes'];
    label = json['label'];
    employeeNotes = json['employee_notes'];
    roomArea = json['room_area'];
    premiumService = json['premium_service'];
    paymentMethods = json['paymentMethods'];
    orderStatus = json['order_status'];
    workingDay = json['workingDay'];
    price = json['price'];
    acceptJobCount = json['accept_job_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['location'] = this.location;
    data['repeatState'] = this.repeatState;
    data['numberSessions'] = this.numberSessions;
    data['duration'] = this.duration;
    data['repeat'] = this.repeat;
    data['location2'] = this.location2;
    data['work_time'] = this.workTime;
    data['pet_notes'] = this.petNotes;
    data['label'] = this.label;
    data['employee_notes'] = this.employeeNotes;
    data['room_area'] = this.roomArea;
    data['premium_service'] = this.premiumService;
    data['paymentMethods'] = this.paymentMethods;
    data['order_status'] = this.orderStatus;
    data['workingDay'] = this.workingDay;
    data['price'] = this.price;
    data['accept_job_count'] = this.acceptJobCount;
    return data;
  }
}
