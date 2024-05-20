class Determined {
  String? idID;
  String? lat;
  String? lng;
  String? location;
  String? location2;
  String? workTime;
  String? petNotes;
  int? label;
  int? repeatState;
  String? numberSessions;
  String? duration;
  String? repeat;
  String? employeeNotes;
  String? roomArea;
  int? premiumService;
  int? orderStatus;
  String? workingDay;
  int? paymentMethods;
  int? price;

  Determined(
      {this.idID,
      this.lat,
      this.lng,
      this.location,
      this.location2,
      this.workTime,
      this.petNotes,
      this.label,
      this.repeatState,
      this.numberSessions,
      this.duration,
      this.repeat,
      this.employeeNotes,
      this.roomArea,
      this.premiumService,
      this.orderStatus,
      this.workingDay,
      this.paymentMethods,
      this.price});

  Determined.fromJson(Map<String, dynamic> json) {
    idID = json['idID'];
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
    location2 = json['location2'];
    workTime = json['work_time'];
    petNotes = json['pet_notes'];
    label = json['label'];
    repeatState = json['repeatState'];
    numberSessions = json['numberSessions'];
    duration = json['duration'];
    repeat = json['repeat'];
    employeeNotes = json['employee_notes'];
    roomArea = json['room_area'];
    premiumService = json['premium_service'];
    orderStatus = json['order_status'];
    workingDay = json['workingDay'];
    paymentMethods = json['payment_methods'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idID'] = this.idID;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['location'] = this.location;
    data['location2'] = this.location2;
    data['work_time'] = this.workTime;
    data['pet_notes'] = this.petNotes;
    data['label'] = this.label;
    data['repeatState'] = this.repeatState;
    data['numberSessions'] = this.numberSessions;
    data['duration'] = this.duration;
    data['repeat'] = this.repeat;
    data['employee_notes'] = this.employeeNotes;
    data['room_area'] = this.roomArea;
    data['premium_service'] = this.premiumService;
    data['order_status'] = this.orderStatus;
    data['workingDay'] = this.workingDay;
    data['payment_methods'] = this.paymentMethods;
    data['price'] = this.price;
    return data;
  }
}
