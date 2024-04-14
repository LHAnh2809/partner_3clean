import 'package:get/get.dart';
import 'package:partner_3clean/app/modules/notification/exports.dart';
import '../../account/exports.dart';
import '../../calendar/view/calender_view.dart';
import '../../job/views/Job_view.dart';

class NavigationBarController extends GetxController {
  final Rx<int> selecteIndex = 0.obs;

  final srceens = [
    const JobView(),
    CalenderView(),
    CalenderView(),
    const NotificationView(),
    const AccountView(),
  ];
}
