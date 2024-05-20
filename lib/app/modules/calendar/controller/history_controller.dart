import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/cancel_complete_history_models/cancel_complete_history.dart';
import '../../../data/repository/api_helper.dart';

class HistoryController extends GetxController
    with StateMixin<List<CancelCompleteHistory>>, SingleGetTickerProviderMixin {
  final ApiHelper _apiHelper = Get.find();
  List<CancelCompleteHistory> listCancelCompleteHistory = [];
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    getCancellationJobHistory();
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();

    super.onClose();
  }

  void tabControllerIndex(index) {
    selectedIndex.value = index;
    tabController.animateTo(index);
  }

  var selectedIndex = 0.obs;

  void selectTab(int index) {
    selectedIndex.value = index;
  }

  Future<void> getCancellationJobHistory() async {
    try {
      change(null, status: RxStatus.loading());
      listCancelCompleteHistory.clear();
      final response = await _apiHelper.getCancelCompleteHistory();
      if (response['status'] == "OK") {
        if (response['cancel_complete_history'] != null &&
            response['cancel_complete_history'].length > 0) {
          for (var jobDetailsJson in response['cancel_complete_history']) {
            CancelCompleteHistory data =
                CancelCompleteHistory.fromJson(jobDetailsJson);
            listCancelCompleteHistory.add(data);
          }
          if (listCancelCompleteHistory.length >= 1) {
            change(listCancelCompleteHistory.cast<CancelCompleteHistory>(),
                status: RxStatus.success());
          } else {
            change(listCancelCompleteHistory.cast<CancelCompleteHistory>(),
                status: RxStatus.empty());
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
