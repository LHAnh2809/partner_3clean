import 'package:flutter/material.dart';
import 'package:partner_3clean/app/data/repository/api_helper.dart';
import 'package:partner_3clean/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../common/util/exports.dart';

class AccountController extends GetxController {
  final ApiHelper _apiHelper = Get.find();

  void getLogout() async {
    try {
      String? accessToken = Storage.getValue<String>('access_token');
      if (accessToken != null) {
        await _apiHelper.logout(accessToken: accessToken);
        await Storage.clearStorage();
        Get.offAllNamed(Routes.login);
      } else {
        // Xử lý trường hợp access token không tồn tại
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
