import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/data/models/job_all_models/job_all.dart';
import '../../../common/util/exports.dart';
import '../../../data/repository/api_helper.dart';

class JobAllController extends GetxController with StateMixin<List<JobAll>> {
  final ApiHelper _apiHelper = Get.find();

  @override
  void onInit() {
    _getCurrentLocation();
    super.onInit();
  }

  var isChecked = false.obs;
  Position? _position;

  void _getCurrentLocation() async {
    try {
      change(null, status: RxStatus.loading());
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _position = position;
      textLat.value = _position!.latitude.toString();
      textLng.value = _position!.longitude.toString();
      await getJobAll();
    } catch (e) {
      print('Could not get current location: $e');
    }
  }

  var textLat = "".obs;
  var textLng = "".obs;

  List<JobAll> jobDetailsList = [];

  Future<void> getJobAll() async {
    try {
      change(null, status: RxStatus.loading());
      jobDetailsList.clear();
      final response = await _apiHelper.getJob();
      if (response['status'] == "OK") {
        if (response['job_all'] != null && response['job_all'].length > 0) {
          for (var jobDetailsJson in response['job_all']) {
            JobAll data = JobAll.fromJson(jobDetailsJson);
            var km = (Geolocator.distanceBetween(
                        double.parse(data.lat.toString()),
                        double.parse(data.lng.toString()),
                        double.parse(textLat.toString()),
                        double.parse(textLng.toString())) /
                    1000)
                .truncate();
            // if (km < 10) {
            jobDetailsList.add(data);
            // }
          }
          if (jobDetailsList.length == 1) {
            change(jobDetailsList, status: RxStatus.success());
          } else {
            change(jobDetailsList, status: RxStatus.success());
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

  void posttAcceptJob(String id) async {
    try {
      final response = await _apiHelper.postAcceptJob(id: id);
      if (response['detail'] == 0) {
        getJobAll();
        Get.back();
        return Utils.showSnackbar('Ứng tuyển công việc thành công',
            AppImages.iconCircleCheck, AppColors.kSuccess600Color);
      }
    } catch (e) {
      debugPrint('Error in getPendingInvoicee: $e');
    }
  }
}
