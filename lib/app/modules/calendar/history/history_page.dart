import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/common/values/styles/app_text_style.dart';
import 'package:partner_3clean/app/modules/calendar/controller/history_controller.dart';
import 'package:partner_3clean/app/modules/calendar/history/history_cancel_complete/cancel/cancel_page.dart';
import 'package:partner_3clean/app/modules/calendar/history/history_cancel_complete/complete/complete_page.dart';

import '../../../common/util/exports.dart';
import '../../notification/exports.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/custom_empty_widget.dart';
import '../../widgets/job_details_widget.dart';
import '../controller/calendar_controller.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HistoryController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        title: 'Lịch sử',
      ),
      body: Column(
        children: [
          Obx(() => TabBar(
                onTap: (index) {
                  controller.selectTab(index);
                },
                controller: controller.tabController,
                labelPadding: const EdgeInsets.only(left: 16, right: 16).r,
                physics: const NeverScrollableScrollPhysics(),
                dividerHeight: 0,
                padding: const EdgeInsets.only(left: 16, right: 16).r,
                unselectedLabelColor: AppColors.kGrayTextColor,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: const BoxDecoration(),
                labelColor: AppColors.white,
                tabs: [
                  _buildTab(controller.selectedIndex.value, 'Hoàn thành', 0),
                  _buildTab(controller.selectedIndex.value, 'Đã hủy', 1),
                ],
              )),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CompletePage(
                  controller: controller,
                ),
                CancelPage(
                  controller: controller,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(int selectedIndex, String text, int index) {
    return Tab(
      child: Column(
        children: [
          // ignore: unrelated_type_equality_checks
          if (selectedIndex == index)
            Container(
              height: 32.h,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(48).r,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16).r,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimens.fontSize14,
                      fontFamily: "SFProText",
                    ),
                  ),
                ),
              ),
            ),
          // ignore: unrelated_type_equality_checks
          if (selectedIndex != index)
            Container(
              height: 32.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48).r,
                border: Border.all(
                  // ignore: unrelated_type_equality_checks
                  color: selectedIndex != index
                      ? AppColors.kGrayTextColor
                      : Colors.transparent,
                  // ignore: unrelated_type_equality_checks
                  width: selectedIndex != index ? 1.w : 0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16).r,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimens.fontSize14,
                      fontFamily: "SFProText",
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
