import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../common/util/exports.dart';
import '../../../../common/util/navigator.dart';
import '../../../../data/models/calendar_models/jobs.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../../controller/calendar_controller.dart';

class CancelJobWidget extends StatelessWidget {
  final CalendarsController controller;
  final Jobs model;
  const CancelJobWidget(
      {Key? key, required this.controller, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Huỷ công việc',
              style: AppTextStyle.textButtonStyle
                  .copyWith(color: AppColors.kGray1000Color),
            ),
            ButtonWidget(
              onTap: () {
                Get.back();
              },
              widget: SvgPicture.asset(
                AppImages.iconClose,
                width: 24.w,
                height: 24.h,
              ),
              boder: false.obs,
            )
          ],
        ),
        SizedBox(width: 0.0, height: 16.h),
        Text(
          'Bạn được huỷ miễn phí trong 2 trường hợp sau:',
          style: AppTextStyle.textbodyStyle,
        ),
        SizedBox(width: 0.0, height: 8.h),
        Text(
          ' 1. Huỷ khi chưa có ai nhận việc\n\n 2. Huỷ trước giờ làm việc ít nhất 6 tiếng',
          style: AppTextStyle.textsmallStyle
              .copyWith(color: AppColors.kGray600Color),
        ),
        SizedBox(width: 0.0, height: 8.h),
        Text(
          'Ngoài 2 trường hợp trên, bạn sẽ bị tính phí theo các mức như sau:',
          style: AppTextStyle.textbodyStyle,
        ),
        SizedBox(width: 0.0, height: 8.h),
        Text(
          ' 1. Phí huỷ 20,000đ nếu huỷ trước khi công việc bắt đầu 1 giờ, tức là trước ${controller.formattedNewStartTime}, ${controller.formattedDate}\n\n 2. Phí huỷ 30% giá trị công việc nếu huỷ trong vòng 1 giờ trước khi công việc bắt đầu, tức là sau ${controller.formattedNewStartTime}, ${controller.formattedDate}',
          style: AppTextStyle.textsmallStyle
              .copyWith(color: AppColors.kGray600Color),
        ),
        SizedBox(width: 0.0, height: 16.h),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.kRrror100Color,
            borderRadius: BorderRadius.circular(8).r,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                AppImages.iconErrorWarning,
                width: 24.w,
                height: 24.h,
                color: AppColors.kRrror700Color,
              ),
              SizedBox(width: 8.w, height: 0.h),
              Text(
                'Độ tin cậy của bạn sẽ giảm nếu huỷ nhiều lần.',
                style: AppTextStyle.textxsmallStyle
                    .copyWith(color: AppColors.kRrror700Color),
              ),
            ],
          ).paddingOnly(left: 16),
        ),
        SizedBox(width: 0.0, height: 16.h),
        Row(
          children: [
            Expanded(
              child: ButtonWidget(
                onTap: () {
                  Get.back();
                },
                colorBackGroud: Colors.white,
                text: 'Quay lại',
                boder: true.obs,
                textStyle: AppTextStyle.textButtonStyle
                    .copyWith(color: AppColors.kGray1000Color),
              ),
            ),
            SizedBox(width: 16.w, height: 0.0),
            Expanded(
              child: Column(
                children: [
                  ButtonWidget(
                    onTap: () {
                      },
                    text: 'Đồng ý hủy',
                    boder: false.obs,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
