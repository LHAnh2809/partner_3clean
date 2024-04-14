class JobAll {
  String? id;
  String? lat;
  String? lng;
  String? location;
  String? location2;
  String? workTime;
  String? petNotes;
  int? label;
  String? employeeNotes;
  String? roomArea;
  String? workingDay;
  int? premiumService;
  int? orderStatus;
  int? price;
  int? acceptJobCount;

  JobAll(
      {this.id,
      this.lat,
      this.lng,
      this.location,
      this.location2,
      this.workTime,
      this.petNotes,
      this.label,
      this.employeeNotes,
      this.roomArea,
      this.premiumService,
      this.orderStatus,
      this.price,
      this.workingDay,
      this.acceptJobCount});

  JobAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
    location2 = json['location2'];
    workTime = json['work_time'];
    petNotes = json['pet_notes'];
    label = json['label'];
    employeeNotes = json['employee_notes'];
    roomArea = json['room_area'];
    premiumService = json['premium_service'];
    orderStatus = json['order_status'];
    price = json['price'];
    workingDay = json['workingDay'];
    acceptJobCount = json['accept_job_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['location'] = this.location;
    data['location2'] = this.location2;
    data['work_time'] = this.workTime;
    data['pet_notes'] = this.petNotes;
    data['label'] = this.label;
    data['employee_notes'] = this.employeeNotes;
    data['room_area'] = this.roomArea;
    data['premium_service'] = this.premiumService;
    data['order_status'] = this.orderStatus;
    data['price'] = this.price;
    data['workingDay'] = this.workingDay;
    data['accept_job_count'] = this.acceptJobCount;
    return data;
  }
}
