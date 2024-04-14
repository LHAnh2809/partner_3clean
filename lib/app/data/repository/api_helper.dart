abstract class ApiHelper {
  Future<Map<String, dynamic>> portCreateUsers({
    required String password,
    required String phoneNumber,
    required String email,
    required String name,
    required int sex,
    required String datebirth,
    required String referralCode,
  });

  Future<Map<String, dynamic>> requestEmail({required String email});

  Future<Map<String, dynamic>> logout({required String accessToken});

  Future<List<Map<String, dynamic>>> vietMapAutoComplete(
      {required String location});

  Future<List<Map<String, dynamic>>> getPlaceVietMap({required String refId});

  Future<List<Map<String, dynamic>>> getReverseVietMap(
      {required String lat, required String lng});

  Future<Map<String, dynamic>> getLocation();

  Future<Map<String, dynamic>> delLocation(
      {required String id, required int defaultt});
  Future<Map<String, dynamic>> putLocation(
      {required String id, required String idUsers});

  Future<Map<String, dynamic>> postVerifyToken({required String token});

  Future<Map<String, dynamic>> getHomePage();

  Future<Map<String, dynamic>> getServiceDuration();

  Future<Map<String, dynamic>> getUsers();

  Future<Map<String, dynamic>> getPendingInvoice();

  Future<Map<String, dynamic>> getCustomerPromotions();

  Future<Map<String, dynamic>> postCustomerPromotions({required String id});

  Future<Map<String, dynamic>> postCheckPromotions({required String id});

  Future<Map<String, dynamic>> postCreateLocation({
    required String location,
    required String location2,
    required String lat,
    required String lng,
  });

  Future<Map<String, dynamic>> postCreateInvoice(
      {required String idP,
      required int label,
      required String nameUser,
      required String phoneNumber,
      required String location,
      required String location2,
      required String lat,
      required String lng,
      required String repeat,
      required String petNote,
      required String employeeNote,
      required String workingDay,
      required String workTime,
      required String roomArea,
      required int price,
      required int gPoints,
      required int paymentMethods,
      required int petStatus,
      required int repeatState});

  Future<Map<String, dynamic>> getNotificationCalendar();

  Future<Map<String, dynamic>> getJobDetails({required String id});

  Future<Map<String, dynamic>> putNotification({required String id});

  // Api đối tác
  Future<Map<String, dynamic>> getSevice();

  Future<Map<String, dynamic>> postPartner({
    required String email,
    required String phonenumber,
    required String name,
    required String password,
    required String service,
    required String image,
    required String datebirth,
    required String cccd,
    required String dateCccd,
    required String address,
    required int sex,
  });

  Future<Map<String, dynamic>> requestOtp(
      {required String email, required String name});

  Future<Map<String, dynamic>> verifyOtp(
      {required String email, required String otp});
  Future<Map<String, dynamic>> forgotPassword(
      {required String email, required String newPassword});
  Future<Map<String, dynamic>> referralCode({required String code});

  Future<Map<String, dynamic>> portLogin(
      {required String email, required String password});

  Future<Map<String, dynamic>> getJob();
  Future<Map<String, dynamic>> getDetermined();

  Future<Map<String, dynamic>> putAcceptJob({required String id});

  Future<Map<String, dynamic>> getWaitConfirmation();

  Future<List<Map<String, dynamic>>> getReverse(
      {required double lat, required double lng});

  Future<Map<String, dynamic>> postAcceptJob({required String id});
  Future<Map<String, dynamic>> getCalendar();
  Future<Map<String, dynamic>> putComplete({required String id});
}
