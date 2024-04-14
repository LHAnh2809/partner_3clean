class WaitConfirmation {
  String? idID;
  String? idAJ;
  String? lat;
  String? lng;
  String? location;
  String? location2;
  String? workTime;
  String? petNotes;
  int? label;
  String? employeeNotes;
  String? roomArea;
  int? premiumService;
  int? orderStatus;
  String? workingDay;
  int? price;
  int? acceptJobCount;
  int? payment_methods;

  WaitConfirmation(
      {this.idID,
      this.idAJ,
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
      this.workingDay,
      this.price,
      this.payment_methods,
      this.acceptJobCount});

  WaitConfirmation.fromJson(Map<String, dynamic> json) {
    idID = json['idID'];
    idAJ = json['idAJ'];
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
    workingDay = json['workingDay'];
    price = json['price'];
    acceptJobCount = json['accept_job_count'];
    payment_methods = json['payment_methods'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idID'] = this.idID;
    data['idAJ'] = this.idAJ;
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
    data['workingDay'] = this.workingDay;
    data['price'] = this.price;
    data['payment_methods'] = this.payment_methods;
    data['accept_job_count'] = this.acceptJobCount;
    return data;
  }
}
