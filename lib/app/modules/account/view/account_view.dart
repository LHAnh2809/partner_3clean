import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/modules/account/view/widgets/button_endow_widget.dart';
import '../../../common/util/exports.dart';
import '../../widgets/button_widget.dart';
import '../exports.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            SizedBox(width: 16.w),
            Text(Strings.account, style: AppTextStyle.titleBodyStyle),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ButtonAvartarWidget(
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Strings.generalInformation,
                    style: AppTextStyle.lableBodyStyle,
                  ),
                  SizedBox(width: 0.0, height: 4.h),
                  Container(
                    height: 1.h,
                    color: AppColors.kGray100Color,
                  ),
                  SizedBox(width: 0.0, height: 4.h),
                  ButtonEndowWidget(
                    onTap: () {},
                    text: Strings.help,
                    image: AppImages.iconQuestion,
                  ),
                  SizedBox(width: 0.0, height: 4.h),
                  Container(
                    height: 1.h,
                    color: AppColors.kGray100Color,
                  ),
                  SizedBox(width: 0.0, height: 4.h),
                  ButtonEndowWidget(
                    onTap: () {},
                    text: Strings.feedbank,
                    image: AppImages.iconMessage,
                  ),
                  SizedBox(width: 0.0, height: 4.h),
                  Container(
                    height: 1.h,
                    color: AppColors.kGray100Color,
                  ),
                  SizedBox(width: 0.0, height: 4.h),
                  ButtonEndowWidget(
                    onTap: () {},
                    text: Strings.setting,
                    image: AppImages.iconSetting,
                  ),
                  SizedBox(width: 0.0, height: 24.h),
                  Text(
                    Strings.termsAndPolicies,
                    style: AppTextStyle.lableBodyStyle,
                  ),
                  SizedBox(width: 0.0, height: 8.h),
                  ButtonEndowWidget(
                    onTap: () {},
                    text: Strings.termsAndPolicies,
                    image: AppImages.iconJob,
                  ),
                  SizedBox(width: 0.0, height: 4.h),
                  Container(
                    height: 1.h,
                    color: AppColors.kGray100Color,
                  ),
                  SizedBox(width: 0.0, height: 4.h),
                  ButtonEndowWidget(
                    onTap: () {},
                    text: Strings.privacyPolicy,
                    image: AppImages.iconPrivacyPolicy,
                  ),
                  SizedBox(width: 0.0, height: 24.h),
                  ButtonWidget(
                    onTap: () {
                      controller.getLogout();
                    },
                    widget: Container(
                      width: 343.w,
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          border: Border.all(color: AppColors.kGray1000Color)),
                      child: Text(
                        Strings.logOut,
                        style: AppTextStyle.textButtonStyle
                            .copyWith(color: AppColors.black),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
