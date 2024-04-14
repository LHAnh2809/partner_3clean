import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/modules/create_account/controllers/create_account_controller.dart';
import 'package:partner_3clean/app/modules/create_account/view/widgets/qr_scanner.dart';

import '../../../../common/util/exports.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/text_form_widget.dart';

class InformationWidget extends StatelessWidget {
  final CreateAccountController controller;
  const InformationWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16).r,
          child: Column(children: [
            GestureDetector(
              onTap: () {
                if (controller.image.value != null) {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.file(controller.image.value!),
                          ButtonWidget(
                            colorBackGroud: AppColors.white,
                            onTap: () {
                              // Clear the selected image
                              controller.image.value = null;
                              Navigator.pop(context); // Close the dialog
                            },
                            text: 'Xoá ảnh',
                            textStyle: AppTextStyle.textButtonStyle
                                .copyWith(color: AppColors.kGray1000Color),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  controller.showImageSource(context);
                }
              },
              child: Obx(
                () => Container(
                  width: 160.w,
                  height: 210.h,
                  decoration: BoxDecoration(
                    color: AppColors.kGray200Color,
                    border: Border.all(
                      color: AppColors.kGray1000Color,
                    ),
                  ),
                  child: controller.image.value != null
                      ? Image.file(
                          controller.image.value!,
                          width: 160,
                          height: 210,
                          fit: BoxFit.cover,
                        )
                      : SvgPicture.asset(AppImages.iconsUserFill),
                ),
              ),
            ),
            SizedBox(width: 0.0, height: 10.h),
            Obx(() => Column(
                  children: [
                    SizedBox(width: 0.0, height: 16.h),
                    if (controller.textQrCode == "")
                      ButtonWidget(
                        onTap: () {
                          Get.to(const QrScanner())!.then((result) {
                            if (result != null) {
                              String qrCode = result as String;
                              controller.textQrCode.value = qrCode;
                              controller.formatData(qrCode);
                            }
                          });
                        },
                        text: 'Quét QR CCCD gắn chíp',
                      ),
                    if (controller.textQrCode != "")
                      Column(
                        children: [
                          TextFormWidget(
                            enabled: false,
                            controller: controller.textCCCDController,
                            hintText: 'Số Căn Cước Công Dân',
                            textInputType: TextInputType.text,
                            obscureText: false.obs,
                            togglePasswordVisibility: () {},
                            showButton: false,
                            onChanged: (value) {},
                          ),
                          SizedBox(width: 0.0, height: 10.h),
                          TextFormWidget(
                            enabled: false,
                            controller: controller.textNameController,
                            hintText: 'Họ Và tên',
                            textInputType: TextInputType.text,
                            obscureText: false.obs,
                            togglePasswordVisibility: () {},
                            showButton: false,
                            onChanged: (value) {},
                          ),
                          SizedBox(width: 0.0, height: 10.h),
                          TextFormWidget(
                            enabled: false,
                            controller: controller.textNgaySinhController,
                            hintText: "Ngày sinh",
                            textInputType: TextInputType.text,
                            obscureText: false.obs,
                            togglePasswordVisibility: () {},
                            showButton: false,
                            onChanged: (value) {},
                          ),
                          SizedBox(width: 0.0, height: 10.h),
                          TextFormWidget(
                            enabled: false,
                            controller: controller.textGioiTinhController,
                            hintText: "Giới tính",
                            textInputType: TextInputType.text,
                            obscureText: false.obs,
                            togglePasswordVisibility: () {},
                            showButton: false,
                            onChanged: (value) {},
                          ),
                          SizedBox(width: 0.0, height: 10.h),
                          TextFormWidget(
                            enabled: false,
                            controller: controller.textDiaChiController,
                            hintText: 'Địa chỉ',
                            textInputType: TextInputType.text,
                            obscureText: false.obs,
                            togglePasswordVisibility: () {},
                            showButton: false,
                            onChanged: (value) {},
                          ),
                          SizedBox(width: 0.0, height: 10.h),
                          TextFormWidget(
                            enabled: false,
                            controller: controller.textNgayTaoTheController,
                            hintText: 'Ngày Mở Thẻ',
                            textInputType: TextInputType.text,
                            obscureText: false.obs,
                            togglePasswordVisibility: () {},
                            showButton: false,
                            onChanged: (value) {},
                          ),
                          SizedBox(width: 0.0, height: 10.h),
                        ],
                      ),
                  ],
                ))
          ]),
        ),
      ],
    );
  }
}
