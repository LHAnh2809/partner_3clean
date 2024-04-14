import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../common/util/exports.dart';
import '../../widgets/button_widget.dart';
import '../exports.dart';
import 'widgets/account_widget.dart';
import 'widgets/information_widget.dart';
import 'widgets/register_service.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        actions: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset(
              AppImages.iconBack,
              height: 24.h,
              width: 24.w,
            ),
          ),
          SizedBox(width: 10.w)
        ],
        title: Center(
          child: Text(
            'Đăng ký tài khoản',
            style:
                AppTextStyle.textButtonStyle.copyWith(color: AppColors.black),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AccountWidget(controller: controller),
                InformationWidget(controller: controller),
                RegisterService(controller: controller),
              ],
            ),
          ),
          Obx(
            () => SizedBox(
              width: 375.w,
              height: 110.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                    child: TabBar(
                      onTap: (index) {
                        controller.selectTab(index);
                      },
                      isScrollable: false,
                      controller: controller.tabController,
                      labelPadding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.label,
                      padding: EdgeInsets.zero,
                      unselectedLabelColor: AppColors.kGrayTextColor,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      indicator: const BoxDecoration(),
                      tabs: [
                        _buildTab(0),
                        _buildTab(1),
                        _buildTab(2),
                      ],
                    ),
                  ),
                  controller.selectedIndex.value == 2
                      ? Column(
                          children: [
                            if (controller.isLoading == false)
                              Container(
                                width: 375.w,
                                height: 74.h,
                                padding: const EdgeInsets.only(
                                        top: 16, left: 16, right: 16, bottom: 8)
                                    .r,
                                child: ButtonWidget(
                                  onTap: () {
                                    controller.posttPartner();
                                  },
                                  text: 'Hoàn tất đăng ký',
                                  width: 120.w,
                                  height: 48.h,
                                  colorBackGroud: AppColors.kButtonColor,
                                ),
                              ),
                            if (controller.isLoading == true)
                              Container(
                                width: 375.w,
                                height: 74.h,
                                padding: const EdgeInsets.only(
                                    top: 16, left: 16, right: 16, bottom: 8),
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 45.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.kButtonColor,
                                      borderRadius: BorderRadius.circular(8).r,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.kButtonColor
                                              .withOpacity(0.2),
                                          blurRadius: 10,
                                        )
                                      ],
                                    ),
                                    child:
                                        LoadingAnimationWidget.fourRotatingDots(
                                            color: AppColors.white,
                                            size: 30.r)),
                              ),
                          ],
                        )
                      : Column(
                          children: [
                            if (controller.isLoading == false)
                              Container(
                                width: 375.w,
                                height: 74.h,
                                padding: const EdgeInsets.only(
                                        top: 16, left: 16, right: 16, bottom: 8)
                                    .r,
                                child: ButtonWidget(
                                  onTap: () async {
                                    final int nextTabIndex =
                                        (controller.selectedIndex.value + 1) %
                                            3;
                                    if (controller.selectedIndex.value == 0) {
                                      if (controller
                                              .checkTextControllersNotEmpty() ==
                                          true) {
                                      } else {
                                        controller.getrequestOtp(
                                          controller
                                              .textEmailController.value.text,
                                        );
                                        String email = controller
                                            .textEmailController.value.text;

                                        Get.bottomSheet(
                                          Container(
                                            padding: const EdgeInsets.only(
                                                    top: 20,
                                                    left: 20,
                                                    right: 20)
                                                .r,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                topRight: Radius.circular(20.0),
                                              ),
                                            ),
                                            child: OtpAuthenticationView(
                                              email: email,
                                              controller:
                                                  CreateAccountController(),
                                            ),
                                          ),
                                        ).then((value) {
                                          controller.selectTab(nextTabIndex);
                                          controller
                                              .onTabIndexChanged(nextTabIndex);
                                        });
                                      }
                                    } else if (controller.selectedIndex.value ==
                                        1) {
                                      controller.isLoading.value = true;
                                      File imageFile =
                                          File(controller.image.value!.path);
                                      String imageName = imageFile.path;
                                      final imageUrl = await Utils
                                          .uploadFileToFirebaseStorage(
                                        "avartar_parter",
                                        imageName,
                                        controller.textNameController.text,
                                      );
                                      controller.isLoading.value = false;
                                      // ignore: unnecessary_null_comparison
                                      if (imageUrl != null) {
                                        controller.imageUrl.value =
                                            imageUrl.toString();
                                      } else {
                                        print('Failed to upload image.');
                                      }
                                      controller.selectTab(nextTabIndex);
                                      controller
                                          .onTabIndexChanged(nextTabIndex);
                                    }
                                  },
                                  text: 'Tiếp tục',
                                  width: 120.w,
                                  height: 48.h,
                                  colorBackGroud: AppColors.kButtonColor,
                                ),
                              ),
                            if (controller.isLoading == true)
                              Container(
                                width: 375.w,
                                height: 74.h,
                                padding: const EdgeInsets.only(
                                    top: 16, left: 16, right: 16, bottom: 8),
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 45.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.kButtonColor,
                                      borderRadius: BorderRadius.circular(8).r,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.kButtonColor
                                              .withOpacity(0.2),
                                          blurRadius: 10,
                                        )
                                      ],
                                    ),
                                    child:
                                        LoadingAnimationWidget.fourRotatingDots(
                                            color: AppColors.white,
                                            size: 30.r)),
                              ),
                          ],
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(int index) {
    return Tab(
      child: controller.selectedIndex >= index
          ? Container(
              width: 123.w,
              height: 4.h,
              color: AppColors.black,
            )
          : Container(
              width: 123.w,
              height: 4.h,
              color: AppColors.kGray200Color,
            ),
    );
  }
}
