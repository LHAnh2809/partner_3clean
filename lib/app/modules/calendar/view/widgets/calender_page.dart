import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../common/util/exports.dart';
import '../../../../data/models/calendar_models/calendar.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/custom_empty_widget.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/job_details_widget.dart';
import '../../controller/calendar_controller.dart';
import 'detailed_work_schedule_page.dart';

class CalenderPage extends GetView<CalendarsController> {
  final List<Calendar>? model;
  const CalenderPage({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Tab Bar
        Container(
          color: AppColors.white,
          width: double.infinity,
          height: 80.h,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: model!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return Obx(() => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.current.value = index;
                            controller.pageController.animateToPage(
                              controller.current.value,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.ease,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            width: 64.w,
                            height: 64.h,
                            decoration: BoxDecoration(
                              color: controller.current == index
                                  ? Colors.white70
                                  : Colors.white54,
                              borderRadius: controller.current == index
                                  ? BorderRadius.circular(12)
                                  : BorderRadius.circular(7),
                              border: controller.current == index
                                  ? Border.all(
                                      color: Colors.deepPurpleAccent,
                                      width: 2.5)
                                  : null,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      index == 0
                                          ? 'Hôm nay'
                                          : index == 1
                                              ? 'Ngày mai'
                                              : model![index].day.toString(),
                                      style: AppTextStyle.textsmallStyle10
                                          .copyWith(
                                        color: controller.current == index
                                            ? AppColors.kGray1000Color
                                            : AppColors.kGray400Color,
                                      )),
                                  Text(model![index].firstDay.toString(),
                                      style:
                                          AppTextStyle.textbodyStyle.copyWith(
                                        color: controller.current == index
                                            ? AppColors.kGray1000Color
                                            : AppColors.kGray400Color,
                                      )),
                                  Text(
                                    model![index].jobSalary.toString() == '0'
                                        ? ''
                                        : '${model![index].jobSalary.toString()} việc',
                                    style:
                                        AppTextStyle.textsmallStyle10.copyWith(
                                      color: controller.current == index
                                          ? Colors.deepPurpleAccent
                                          : AppColors.kGray400Color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: controller.current == index,
                          child: Container(
                    
                            width: 5.w,
                            height: 5.h,
                            decoration: const BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                shape: BoxShape.circle),
                          ),
                        )
                      ],
                    ));
              }),
        ),
        /// MAIN BODY
        Container(
          margin: const EdgeInsets.only(top: 30),
          color: AppColors.white,
          width: double.infinity,
          height: 520.h,
          child: PageView.builder(
            itemCount: controller.listCalendar.length,
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, inx) {
              if (controller.listCalendar[inx].jobs!.isNotEmpty) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.listCalendar[inx].jobs!.length,
                  itemBuilder: (context, index) {
                    final modell = controller.listCalendar[inx].jobs![index];

                    return ButtonWidget(
                      onTap: () {
                        Get.to(() => DetailedWorkSchedulePage(
                            model: modell, controller: controller));
                      },
                      widget: Container(
                        margin: const EdgeInsets.only(left: 16, right: 16).r,
                        padding: const EdgeInsets.all(16).r,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12).r,
                          border: Border.all(color: AppColors.kGray200Color),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.04),
                              blurRadius: 6.r,
                              spreadRadius: -2,
                              offset: const Offset(0, 4),
                            ),
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.08),
                              blurRadius: 15.r,
                              spreadRadius: -3,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Utils.getLabel(
                                      int.parse(modell.label.toString())),
                                  style: AppTextStyle.lableBodyStyle,
                                ),
                                if (modell.orderStatus == 4)
                                  CustomSvg(
                                    image: AppImages.iconCircleCheck,
                                    color: AppColors.kSuccess600Color,
                                    width: 24.w,
                                    height: 24.h,
                                  )
                              ],
                            ),
                            SizedBox(width: 0.0, height: 12.h),
                            JobDetailsWidget(
                              image: AppImages.iconTime,
                              text: Utils.getHourStart(
                                  modell.workTime.toString()),
                              textStyle: AppTextStyle.lableBodyStyle,
                            ),
                            SizedBox(width: 0.0, height: 12.h),
                            JobDetailsWidget(
                              image: AppImages.iconLocation2,
                              text: modell.location.toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.h,
                  ),
                );
              } else {
                return Center(child: CustomEmptyWidget(top: 0.12.sh));
              }
            },
          ),
        ),
      ],
    );
  }
}
