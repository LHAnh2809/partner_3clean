import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/common/util/exports.dart';

import '../../../data/models/calendar_models/calendar.dart';
import '../../../data/models/cancel_complete_history_models/cancel_complete_history.dart';
import '../../../data/repository/api_helper.dart';

class CalendarsController extends GetxController
    with StateMixin<List<Calendar>>, SingleGetTickerProviderMixin {
  final ApiHelper _apiHelper = Get.find();

  @override
  void onInit() {
    getCalendarr();
    super.onInit();
  }

  List<Calendar> listCalendar = [];
  var previousCurrentIndex = 0.obs;

  Future<void> getCalendarr() async {
    try {
      previousCurrentIndex.value = current.value;
      change(null, status: RxStatus.loading());
      listCalendar.clear();
      final response = await _apiHelper.getCalendar();
      if (response['status'] == "OK") {
        if (response['calendar'] != null && response['calendar'].length > 0) {
          for (var jobDetailsJson in response['calendar']) {
            Calendar data = Calendar.fromJson(jobDetailsJson);
            listCalendar.add(data);
          }
          if (listCalendar.length >= 1) {
            change(listCalendar, status: RxStatus.success());
            current.value = 0;
          } else {
            change(listCalendar, status: RxStatus.empty());
            current.value = 0;
          }
        } else {
          change(null, status: RxStatus.empty());
          current.value = 0;
        }
      } else {
        change(null, status: RxStatus.error());
        current.value = 0;
      }
    } catch (e) {
      debugPrint('Error in getPendingInvoicee: $e');
      change(null, status: RxStatus.error());
      current.value = 0;
    }
  }

  var orderStatuss = 0.obs;
  var current = 0.obs;
  PageController pageController = PageController();

  void puttComplete(String id) async {
    try {
      final response = await _apiHelper.putComplete(id: id);
      if (response['detail'] == "OK") {
        getCalendarr();
        orderStatuss.value = 4;
        return Utils.showSnackbar(
            'Hoàn tất công việc hãy chờ khác hàng xác nhận',
            AppImages.iconCircleCheck,
            AppColors.kSuccess600Color);
      } else {}
    } catch (e) {
      debugPrint('Error in getPendingInvoicee: $e');
    }
  }

  var idPC = "";
  Future<void> postCreateChatt(String id) async {
    try {
      final response = await _apiHelper.postCreateChat(id: id);
      if (response['detail'] == 0) {
        idPC = response['id'];
        debugPrint('Tạo cuộc trò chuyện thành công');
      } else if (response['detail'] == -1) {
        idPC = response['id'];
        debugPrint('Cuộc trò chuyện đã tồn tại');
      } else {
        debugPrint('Tạo cuộc trò chuyện thất bại');
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
