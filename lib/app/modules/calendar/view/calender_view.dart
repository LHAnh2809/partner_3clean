import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/common/util/exports.dart';
import 'package:partner_3clean/app/modules/calendar/controller/calendar_controller.dart';
import 'package:partner_3clean/app/modules/widgets/custom_empty_widget.dart';

import '../../notification/exports.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/job_details_widget.dart';
import 'widgets/calender_page.dart';

class CalenderView extends GetView<CalendarsController> {
  const CalenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Lịch làm việc', style: AppTextStyle.titleBodyStyle),
          ],
        ),
        backgroundColor: AppColors.white,
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
