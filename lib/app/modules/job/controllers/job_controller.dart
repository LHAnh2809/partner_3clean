import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  var selectedIndex = 0.obs;

  void selectTab(int index) {
    selectedIndex.value = index;
  }
}
