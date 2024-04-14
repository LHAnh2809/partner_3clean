import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/modules/create_account/exports.dart';

import '../../../../common/util/exports.dart';

class RegisterService extends StatelessWidget {
  final CreateAccountController controller;
  const RegisterService({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chọn dịch vụ bạn có thể làm',
            style: AppTextStyle.titleBodyStyle,
          ),
          SizedBox(width: 0.0, height: 24.h),
          Obx(
            () => Wrap(
              spacing: 8.w, // Khoảng cách giữa các hình ảnh
              runSpacing: 8.h, // Khoảng cách giữa các dòng
              children: List.generate(
                controller.listSevice.length,
                (index) {
                  final service = controller.listSevice[index];
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      controller.selectSvOption(index);
                    },
                    child: Container(
                      width: 109.w,
                      height: 109.h,
                      padding: const EdgeInsets.all(12).r,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16).r,
                        border: Border.all(
                          color: controller.isSelectedList[index]
                              ? AppColors.kGray1000Color
                              : AppColors.kGray200Color,
                        ),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            child: SvgPicture.network(
                              service.icon.toString(),
                              color: controller.isSelectedList[index]
                                  ? AppColors.kGray1000Color
                                  : AppColors.kGray500Color,
                              width: 40.w,
                              height: 40.h,
                            ),
                          ),
                          SizedBox(width: 0.0, height: 4.h),
                          Text(
                            textAlign: TextAlign.center,
                            service.name.toString(),
                            style: AppTextStyle.textsmallStyle12.copyWith(
                              color: controller.isSelectedList[index]
                                  ? AppColors.kGray1000Color
                                  : AppColors.kGray500Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
