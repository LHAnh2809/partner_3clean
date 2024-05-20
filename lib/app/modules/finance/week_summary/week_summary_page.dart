import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/common/util/exports.dart';
import 'package:partner_3clean/app/modules/widgets/button_widget.dart';
import 'package:partner_3clean/app/modules/widgets/custom_appbar_widget.dart';

import '../../../common/util/shimmer.dart';
import '../controllers/finance_controller.dart';

class WeekSummaryPage extends StatelessWidget {
  const WeekSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(FinanceController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        title: 'Tổng kết hàng tuần',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 48.h,
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.kGray300Color,
                ),
                top: BorderSide(
                  color: AppColors.kGray300Color,
                ),
              ),
            ),
            child: Obx(() {
              DateTime startOfWeek = controller.currentWeekStart.value;
              DateTime endOfWeek = controller.getEndOfWeek(startOfWeek);
              String formattedStartOfWeek = controller.formatDate(startOfWeek);
              String formattedEndOfWeek = controller.formatDate(endOfWeek);
              controller.getStatisticss(startOfWeek);

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    onTap: controller.previousWeek,
                    widget: SvgPicture.asset(
                      AppImages
                          .iconsArrowLeftLine, // Replace with your asset path
                      width: 24.w,
                      height: 24.h,
                      color: AppColors.kGray1000Color,
                    ),
                  ),
                  SizedBox(width: 16.w, height: 0.0),
                  Text(
                    '$formattedStartOfWeek - $formattedEndOfWeek',
                    style: AppTextStyle.textsmallStyle,
                  ),
                  SizedBox(width: 16.w, height: 0.0),
                  ButtonWidget(
                    onTap: controller
                        .nextWeek, // Không cho phép chuyển tiếp nếu không được kích hoạt
                    widget: SvgPicture.asset(
                      AppImages.iconArrowright, // Replace with your asset path
                      width: 24.w,
                      height: 24.h,
                      color: AppColors
                          .kGray1000Color, // Thay đổi màu sắc nếu không được kích hoạt
                    ),
                  ),
                ],
              );
            }),
          ),
          SizedBox(width: 0.0, height: 16.h),
          Obx(
            () => Wrap(
              spacing: 7, // khoảng cách ngang giữa các container
              runSpacing: 8, // khoảng cách dọc giữa các dòng
              children: [
                buildJobContainer(
                    'Việc đã làm',
                    controller.listStatistics[0].vcdl != null
                        ? controller.listStatistics[0].vcdl.toString()
                        : '0',
                    'Tuần trước: ${controller.listStatistics[1].vcdl.toString()} việc',
                    AppColors.kPurplePurpleColor,
                    AppImages.iconFileListFill),
                buildJobContainer(
                    'Thi nhập (VNĐ)',
                    Utils.formatNumber(int.parse(
                        controller.listStatistics[0].price != null
                            ? controller.listStatistics[0].price
                                .toString()
                            : '0')),
                    'Tuần trước: ${Utils.formatNumber(controller.listStatistics[1].price != null ? int.parse(controller.listStatistics[1].price.toString()) : 0)}',
                    AppColors.kSuccess600Color,
                    AppImages.iconMoneyDollarBox),
                buildJobContainer(
                    'Bình chọn tốt',
                    controller.listStatistics[0].blt.toString(),
                    'Tuần trước: ${controller.listStatistics[1].blt.toString()}',
                    AppColors.kSuccess600Color,
                    AppImages.iconThumbUpFill),
                buildJobContainer(
                    'Bình chọn chưa tốt',
                    controller.listStatistics[0].blx.toString(),
                    'Tuần trước: ${controller.listStatistics[0].blx.toString()}',
                    AppColors.kRrror600Color,
                    AppImages.iconThumbDownFill),
              ],
            ).paddingOnly(left: 16.r, right: 16.r),
          ),
          SizedBox(width: 0.0, height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16).r,
              border: Border.all(
                color: AppColors.kGray300Color,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppImages.iconMessage2Fill,
                  width: 24.w,
                  height: 24.h,
                  color: AppColors.kPurplePurpleColor,
                ),
                SizedBox(width: 0.0, height: 8.h),
                Text(
                  'Gợi ý từ 3Clean:',
                  style: AppTextStyle.textsmallStyle12,
                ),
                SizedBox(width: 0.0, height: 8.h),
                Container(
                  width: 319.h,
                  padding: const EdgeInsets.all(8).r,
                  decoration: BoxDecoration(
                    color: AppColors.kGray100Color,
                    borderRadius: BorderRadius.circular(8).r,
                  ),
                  child: Text(
                    'Cố gắng nhận thêm nhiều việc để tăng thu nhập và hoàn thành tốt công việc để nhận thêm nhiều đánh giá tốt hơn nữa.',
                    style: AppTextStyle.textsmallStyle,
                  ),
                ),
              ],
            ),
          ).paddingOnly(left: 16.r, right: 16.r),
        ],
      ),
    );
  }

  buildJobContainer(String title, String count, String subtitle,
      Color iconColor, String image) {
    return Container(
      width: 168.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16).r,
        border: Border.all(
          color: AppColors.kGray300Color,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            image,
            width: 24.w,
            height: 24.h,
            color: iconColor,
          ),
          SizedBox(width: 0.0, height: 8.h),
          Text(
            title,
            style: AppTextStyle.textsmallStyle12,
          ),
          Text(
            count,
            style: AppTextStyle.titleBodyStyle28,
          ),
          Text(
            subtitle,
            style: AppTextStyle.textxsmallStyle
                .copyWith(color: AppColors.kRrror400Color),
          ),
        ],
      ),
    );
  }
}
