import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/routes/app_pages.dart';

import '../../../common/util/exports.dart';
import '../../../common/util/navigator.dart';
import '../../../data/repository/api_helper.dart';

class LoginController extends GetxController {
  final ApiHelper _apiHelper = Get.find();

  final TextEditingController textEmailController = TextEditingController();
  final TextEditingController textPasswordController = TextEditingController();

  var isPasswordVisible = true.obs;
  var ispasswordOrEmailNull = false.obs;
  var isPasswordOrEmailIncorrect = false.obs;
  var isyourAccountBan = false.obs;

  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  @override
  void onClose() {
    textEmailController.dispose();
    textPasswordController.dispose();
    super.onClose();
  }

  login() async {
    final String email = textEmailController.text;
    final String passWord = textPasswordController.text;
    if (email.trim().isEmpty || passWord.trim().isEmpty) {
      isPasswordOrEmailIncorrect.value = false;
      isyourAccountBan.value = false;
      ispasswordOrEmailNull.value = true;
      return; // Trả về ngay khi email hoặc password rỗng
    }

    try {
      isLoading.value = true;
      final response =
          await _apiHelper.portLogin(email: email, password: passWord);
      final detail = response['detail'];
      if (detail == -1 || detail == -2) {
        isPasswordOrEmailIncorrect.value = true;
        isyourAccountBan.value = false;
        ispasswordOrEmailNull.value = false;
        isLoading.value = false;
        return;
      } else if (detail == -3) {
        isPasswordOrEmailIncorrect.value = false;
        isyourAccountBan.value = true;
        ispasswordOrEmailNull.value = false;
        isLoading.value = false;
        return;
      } else if (detail == -4) {
        isLoading.value = false;

        goPresent(
          // isDismissibles: false,
          children: [
            Text(
              'Tài khoản của bạn đang chờ được xét duyệt',
              style:
                  AppTextStyle.textButtonStyle.copyWith(color: AppColors.black),
            ),
            SizedBox(width: 0.0, height: 16.h),
            Text(
              'Nếu bạn cần thêm thông tin, vui lòng gọi hỗ trợ.',
              style: AppTextStyle.textsmallStyle,
            ),
            SizedBox(width: 0.0, height: 16.h),
          ],
        );
        return;
      } else {
        isLoading.value = true;
        final token = response['access_token'] as String;

        await Storage.saveValue('access_token', token);
        Get.offAllNamed(Routes.navigationBar);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
