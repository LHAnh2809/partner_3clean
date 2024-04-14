import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../common/util/exports.dart';
import '../../../data/models/determined_models/determined.dart';
import '../../../data/repository/api_helper.dart';

class ConfirmedController extends GetxController
    with StateMixin<List<Determined>> {
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
      await gettDetermined();
    } catch (e) {
      print('Could not get current location: $e');
    }
  }

  List<Determined> listDetermined = [];
  var textLat = "".obs;
  var textLng = "".obs;
  Future<void> gettDetermined() async {
    try {
      change(null, status: RxStatus.loading());
      listDetermined.clear();
      final response = await _apiHelper.getDetermined();
      if (response['status'] == "OK") {
        if (response['get_determined'] != null &&
            response['get_determined'].length > 0) {
          for (var jobDetailsJson in response['get_determined']) {
            Determined data = Determined.fromJson(jobDetailsJson);
            listDetermined.add(data);
          }
          if (listDetermined.length >= 1) {
            change(listDetermined, status: RxStatus.success());
          } else {
            change(listDetermined, status: RxStatus.empty());
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
}
