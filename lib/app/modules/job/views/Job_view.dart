import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/common/util/exports.dart';
import 'package:partner_3clean/app/modules/job/exports.dart';
import 'package:partner_3clean/app/modules/job/views/confirmed/confirmed_page.dart';

import '../../navigation_bar/view/widgets/bottomNavigationBarItem_widget.dart';
import '../../widgets/custom_svg.dart';
import 'new_job/new_job_page.dart';
import 'wait_confirmation/wait_confirmation_page.dart';

class JobView extends GetView<JobController> {
  const JobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Công việc cho bạn', style: AppTextStyle.titleBodyStyle),
          ],
        ),
        actions: [
          InkWell(
            onTap: () async {},
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(8).r,
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.kGray100Color,
                borderRadius: BorderRadius.circular(32).r,
              ),
              child: CustomSvg(
                image: AppImages.iconsEqualizerFill,
                color: AppColors.kGray1000Color,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
          SizedBox(width: 16.w),
        ],
        backgroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          Obx(() => TabBar(
                onTap: (index) {
                  controller.selectTab(index);
                },
                controller: controller.tabController,
                labelPadding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                dividerHeight: 0,
                padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 16)
                    .r,
                unselectedLabelColor: AppColors.kGrayTextColor,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: const BoxDecoration(),
                labelColor: AppColors.white,
                tabs: [
                  _buildTab("Việc mới", 0),
                  _buildTab("Chờ xác nhận", 1),
                  _buildTab("Đã xác nhận", 2),
                ],
              )),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                NewJobPage(),
                WaitConfirmationPage(),
                ConfirmedPage()
              ],
            ),
          )
        ],
      ),
    );
  } // Hàm tạo tab

  Widget _buildTab(String text, int index) {
    return Tab(
      child: Column(
        children: [
          // ignore: unrelated_type_equality_checks
          if (controller.selectedIndex == index)
            Container(
              width: 109.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(48).r,
              ),
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
          // ignore: unrelated_type_equality_checks
          if (controller.selectedIndex != index)
            Container(
              width: 109.w,
              height: 32.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48).r,
                border: Border.all(
                  // ignore: unrelated_type_equality_checks
                  color: controller.selectedIndex != index
                      ? AppColors.kGrayTextColor
                      : Colors.transparent,
                  width:
                      // ignore: unrelated_type_equality_checks
                      controller.selectedIndex != index ? 1.w : 0,
                ),
              ),
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
        ],
      ),
    );
  }
}
