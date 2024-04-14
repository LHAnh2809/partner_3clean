
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/util/exports.dart';
import '../../../widgets/text_form_widget.dart';
import '../../exports.dart';

class AccountWidget extends StatelessWidget {
  final CreateAccountController controller;
  const AccountWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(bottom: 40, left: 15, right: 15, top: 10).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 0.0, height: 20.h),
                  TextFormWidget(
                    controller: controller.textEmailController,
                    hintText: Strings.email,
                    textInputType: TextInputType.emailAddress,
                    obscureText: false.obs,
                    togglePasswordVisibility: () {},
                    showButton: false,
                    onChanged: (value) {
                      controller.checkEmailFormat(value);
                    },
                  ),
                ],
              ),
              Obx(
                () {
                  if (controller.isEmailNull.value ||
                      controller.isEmailValid.value) {
                    // Nếu email rỗng hoặc hợp lệ, không hiển thị văn bản lỗi
                    return const SizedBox();
                  } else {
                    // Nếu email không rỗng và không hợp lệ, hiển thị văn bản lỗi
                    return Column(
                      children: [
                        SizedBox(width: 0.0, height: 10.h),
                        Text(
                          Strings.malformedEmail,
                          style: AppTextStyle.textsmallStyle
                              .copyWith(color: Colors.red, fontSize: 12.sp),
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(width: 0.0, height: 10.h),
              TextFormWidget(
                controller: controller.textphoneNumberController,
                hintText: Strings.phoneNumber,
                textInputType: TextInputType.number,
                obscureText: false.obs,
                togglePasswordVisibility: () {},
                showButton: false,
                onChanged: (value) {
                  controller.checkPhoneNumberFormat(value);
                },
              ),
              Obx(
                () {
                  if (controller.isSdtNull.value ||
                      controller.isSdtValid.value) {
                    return const SizedBox();
                  } else {
                    return Column(
                      children: [
                        SizedBox(width: 0.0, height: 10.h),
                        Text(
                          Strings.phoneNumberIncorrect,
                          style: AppTextStyle.textsmallStyle
                              .copyWith(color: Colors.red, fontSize: 12.sp),
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(width: 0.0, height: 10.h),
              TextFormWidget(
                controller: controller.textPasswordController,
                hintText: Strings.password,
                textInputType: TextInputType.visiblePassword,
                obscureText: controller.isPasswordVisible,
                togglePasswordVisibility: () {
                  controller.togglePasswordVisibility();
                },
                showButton: true,
                onChanged: (value) {
                  controller.checkPassWordFormat(value);
                  controller.checkPasswordsMatch(value,
                      controller.textReEnterPasswordController.value.text);
                },
              ),
              SizedBox(width: 0.0, height: 7.h),
              Obx(() {
                return CheckDkPwWidget(
                  text: Strings.characters,
                  color: controller.isCharacters.value
                      ? AppColors.kGreenChart
                      : AppColors.kGreyChart,
                );
              }),
              SizedBox(width: 0.0, height: 5.h),
              Obx(() {
                return CheckDkPwWidget(
                  text: Strings.capitalLetter,
                  color: controller.isCapitalLetter.value
                      ? AppColors.kGreenChart
                      : AppColors.kGreyChart,
                );
              }),
              SizedBox(width: 0.0, height: 5.h),
              Obx(() {
                return CheckDkPwWidget(
                  text: Strings.oneDigit,
                  color: controller.isOneDigit.value
                      ? AppColors.kGreenChart
                      : AppColors.kGreyChart,
                );
              }),
              SizedBox(width: 0.0, height: 10.h),
              TextFormWidget(
                controller: controller.textReEnterPasswordController,
                hintText: Strings.reEnterPassword,
                textInputType: TextInputType.text,
                obscureText: controller.isPasswordVisible,
                togglePasswordVisibility: () {
                  controller.togglePasswordVisibility();
                },
                showButton: true,
                onChanged: (value) {
                  controller.checkPasswordsMatch(
                      controller.textPasswordController.value.text, value);
                },
              ),
              SizedBox(width: 0.0, height: 10.h),
              Obx(
                () {
                  if (controller.isCheckGd.value == false) {
                    return Text(
                      Strings.notTheSame,
                      style: AppTextStyle.textsmallStyle
                          .copyWith(color: Colors.red, fontSize: 12.sp),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
