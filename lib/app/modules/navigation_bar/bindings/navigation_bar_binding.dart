import 'package:get/get.dart';
import 'package:partner_3clean/app/modules/account/controllers/account_controller.dart';
import 'package:partner_3clean/app/modules/finance/controllers/finance_controller.dart';
import 'package:partner_3clean/app/modules/navigation_bar/controllers/navigation_bar_controller.dart';
import 'package:partner_3clean/app/modules/notification/controllers/calendar_controller.dart';
import 'package:partner_3clean/app/modules/notification/controllers/notification_controller.dart';
import 'package:partner_3clean/app/modules/promotion/controllers/promotion_controller.dart';

import '../../calendar/controller/calendar_controller.dart';
import '../../calendar/controller/history_controller.dart';
import '../../chat/view/controllers/chat_controller.dart';
import '../../job/controllers/confirmed_controller.dart';
import '../../job/controllers/job_all_controller.dart';
import '../../job/controllers/wait_confirmation_controller.dart';
import '../../job/exports.dart';

class NavigationBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationBarController>(() => NavigationBarController());
    Get.lazyPut<JobController>(() => JobController());
    Get.lazyPut<WaitConfirmationControlelr>(() => WaitConfirmationControlelr());
    Get.lazyPut<JobAllController>(() => JobAllController());
    Get.lazyPut<PromotionController>(() => PromotionController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<AccountController>(() => AccountController());
    Get.lazyPut<CalendarController>(() => CalendarController());
    Get.lazyPut<ConfirmedController>(() => ConfirmedController());
    Get.lazyPut<CalendarsController>(() => CalendarsController());
    Get.lazyPut<FinanceController>(() => FinanceController());
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
