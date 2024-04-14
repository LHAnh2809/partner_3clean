class Jobs {
  String? idID;
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
  int? payment_methods;
  int? orderStatus;
  int? price;
  String? workingDay;
  String? nameUser;
  String? phoneNumber;

  Jobs(
      {this.idID,
      this.lat,
      this.lng,
      this.location,
      this.location2,
      this.workTime,
      this.payment_methods,
      this.petNotes,
      this.label,
      this.employeeNotes,
      this.roomArea,
      this.premiumService,
      this.orderStatus,
      this.price,
      this.workingDay,
      this.nameUser,
      this.phoneNumber});

  Jobs.fromJson(Map<String, dynamic> json) {
    idID = json['idID'];
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
    payment_methods = json['payment_methods'];
    workingDay = json['workingDay'];
    nameUser = json['name_user'];
    phoneNumber = json['phoneNumber'];
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
    data['employee_notes'] = this.employeeNotes;
    data['room_area'] = this.roomArea;
    data['premium_service'] = this.premiumService;
    data['order_status'] = this.orderStatus;
    data['price'] = this.price;
    data['workingDay'] = this.workingDay;
    data['name_user'] = this.nameUser;
    data['phoneNumber'] = this.phoneNumber;
    data['payment_methods'] = this.payment_methods;
    return data;
  }
}
