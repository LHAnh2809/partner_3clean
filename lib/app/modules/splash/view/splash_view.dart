import 'package:partner_3clean/app/common/util/exports.dart';
import 'package:partner_3clean/app/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getTime();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 48, left: 16, right: 16).r,
          child: Column(
            children: [
              SvgPicture.asset(
                AppImages.logo3Clean,
                height: 70.h,
                width: 200.w,
                color: AppColors.kPurplePurpleColor,
              ),
              SizedBox(width: 0.0, height: 16.h),
              Text(
                'Dành cho nhân viên',
                style: AppTextStyle.largeBodyStyle,
              ),
              SizedBox(width: 0.0, height: 64.h),
              SvgPicture.asset(
                AppImages.illustration,
                height: 214.h,
                width: 343.w,
              ),
              SizedBox(width: 0.0, height: 64.h),
              Text(
                textAlign: TextAlign.center,
                Strings.slogen,
                style: AppTextStyle.lableBodyStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
