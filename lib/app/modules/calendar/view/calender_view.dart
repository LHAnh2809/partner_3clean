import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:partner_3clean/app/common/util/exports.dart';
import 'package:partner_3clean/app/modules/calendar/controller/calendar_controller.dart';
import 'package:partner_3clean/app/modules/widgets/button_widget.dart';
import 'package:partner_3clean/app/modules/widgets/custom_appbar_widget.dart';
import 'package:partner_3clean/app/modules/widgets/custom_empty_widget.dart';
import 'package:partner_3clean/app/modules/widgets/custom_svg.dart';

import '../../notification/exports.dart';
import '../history/history_page.dart';
import 'widgets/calender_page.dart';

class CalenderView extends GetView<CalendarsController> {
  const CalenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        titleWidget: Text("Lịch làm việc", style: AppTextStyle.titleBodyStyle),
        centerTitle: false,
        addBackButton: false,
        actions: [
          ButtonWidget(
            onTap: () {
              Get.to(() => const HistoryPage());
            },
            widget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12).r,
              width: 96.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: AppColors.kWarning100Color,
                borderRadius: BorderRadius.circular(16).r,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    child: CustomSvg(
                      image: AppImages.iconAccessTime,
                      color: AppColors.kWarning700Color,
                      width: 16.w,
                      height: 16.h,
                    ),
                  ),
                  SizedBox(width: 6.w, height: 0.0),
                  Text(
                    Strings.history,
                    style: AppTextStyle.largeBodyStyle.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.kWarning700Color,
                    ),
                  ),
                ],
              ),
            ),
          ).paddingOnly(right: 16),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getCalendarr(),
        child: ListView(
          children: [
            controller.obx(
              (state) {
                final model = controller.listCalendar;
                return CalenderPage(
                  model: model,
                );
              },
              onLoading: const LoadingPage(),
              onEmpty: Center(child: CustomEmptyWidget(top: 0.12.sh)),
              onError: (error) => Center(
                  child: CustomNotFoundWidget(error: error, top: 0.18.sh)),
            ),
          ],
        ),
      ),
    );
  }
}
