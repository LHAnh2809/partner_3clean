import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/data/models/wait_confirmation_models/wait_confirmation.dart';
import '../../../common/util/exports.dart';
import '../../../data/repository/api_helper.dart';

class WaitConfirmationControlelr extends GetxController
    with StateMixin<List<WaitConfirmation>> {
  final ApiHelper _apiHelper = Get.find();

  var textLat = "".obs;
  var textLng = "".obs;

  var isLoading = false.obs;
  @override
  void onInit() {
    _getCurrentLocation();
    // gettWaitConfirmation();
    super.onInit();
  }

  Position? _position;
  var isChecked = false.obs;

  void _getCurrentLocation() async {
    try {
      change(null, status: RxStatus.loading());
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _position = position;
      textLat.value = _position!.latitude.toString();
      textLng.value = _position!.longitude.toString();
      await gettWaitConfirmation();
    } catch (e) {
      print('Could not get current location: $e');
    }
  }

  List<WaitConfirmation> waitConfirmationList = [];

  Future<void> gettWaitConfirmation() async {
    try {
      change(null, status: RxStatus.loading());
      waitConfirmationList.clear();
      final response = await _apiHelper.getWaitConfirmation();
      if (response['status'] == "OK") {
        if (response['wait_confirmation'] != null &&
            response['wait_confirmation'].length > 0) {
          for (var jobDetailsJson in response['wait_confirmation']) {
            WaitConfirmation data = WaitConfirmation.fromJson(jobDetailsJson);

            waitConfirmationList.add(data);
          }
          if (waitConfirmationList.length == 1) {
            change(waitConfirmationList, status: RxStatus.success());
          } else {
            change(waitConfirmationList, status: RxStatus.success());
          }
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      debugPrint('Error in getPendingInvoicee: $e');
      change(null, status: RxStatus.error());
    }
  }

  void puttAcceptJob(String id) async {
    try {
      isLoading.value = true;

      waitConfirmationList.clear();
      final response = await _apiHelper.putAcceptJob(id: id);
      if (response['detail'] == "OK") {
        Get.back();
        isLoading.value = false;
        await gettWaitConfirmation();
        return Utils.showSnackbar(
            message: 'Huỷ công việc ứng tuyển thành công',
            icon: AppImages.iconCircleCheck,
            colors: AppColors.kRrror600Color);
      } else {
        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      debugPrint('Error in getPendingInvoicee: $e');
      isLoading.value = false;
    }
  }
}
