import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:partner_3clean/app/common/util/exports.dart';

import '../../../common/util/navigator.dart';
import '../../../data/models/calendar_models/calendar.dart';
import '../../../data/models/calendar_models/jobs.dart';
import '../../../data/models/cancel_complete_history_models/cancel_complete_history.dart';
import '../../../data/repository/api_helper.dart';
import '../../widgets/button_widget.dart';

class CalendarsController extends GetxController
    with StateMixin<List<Calendar>>, SingleGetTickerProviderMixin {
  final ApiHelper _apiHelper = Get.find();

  @override
  void onInit() {
    getCalendarr();
    super.onInit();
  }

  List<Calendar> listCalendar = [];
  var previousCurrentIndex = 0.obs;

  Future<void> getCalendarr() async {
    try {
      previousCurrentIndex.value = current.value;
      change(null, status: RxStatus.loading());
      listCalendar.clear();
      final response = await _apiHelper.getCalendar();
      if (response['status'] == "OK") {
        if (response['calendar'] != null && response['calendar'].length > 0) {
          for (var jobDetailsJson in response['calendar']) {
            Calendar data = Calendar.fromJson(jobDetailsJson);
            listCalendar.add(data);
          }
          if (listCalendar.length >= 1) {
            change(listCalendar, status: RxStatus.success());
            current.value = 0;
          } else {
            change(listCalendar, status: RxStatus.empty());
            current.value = 0;
          }
        } else {
          change(null, status: RxStatus.empty());
          current.value = 0;
        }
      } else {
        change(null, status: RxStatus.error());
        current.value = 0;
      }
    } catch (e) {
      debugPrint('Error in getPendingInvoicee: $e');
      change(null, status: RxStatus.error());
      current.value = 0;
    }
  }

  var orderStatuss = 0.obs;
  var current = 0.obs;
  PageController pageController = PageController();
  final formattedNewStartTime = RxString('');
  final formattedDate = RxString('');
  void formatTime(String date, String time) {
    // Initialize date formatting for the Vietnamese locale
    initializeDateFormatting('vi_VN', null).then((_) {
      try {
        // Extract the day of the week from the date string
        String dayOfWeek = date.split(',')[0].trim();

        // Parse the date string without the day of the week
        DateFormat inputDateFormat = DateFormat("dd/MM/yyyy", "vi_VN");
        DateTime startDate =
            inputDateFormat.parse(date.substring(dayOfWeek.length + 2).trim());

        // Format the parsed date to a desired format
        formattedDate.value = DateFormat('dd/MM/yyyy').format(startDate);

        // Parse the start time string
        List<String> timeParts = time.split('đến');
        String startTimeString = timeParts[0].trim();
        DateFormat inputTimeFormat = DateFormat('H giờ, HH:mm');
        DateTime startTime = inputTimeFormat.parse(startTimeString);

        // Subtract one hour from the start time
        DateTime newStartTime = startTime.subtract(Duration(hours: 1));

        // Format the new start time
        formattedNewStartTime.value = DateFormat('HH:mm').format(newStartTime);
        print(formattedNewStartTime);
      } catch (e) {
        // Handle any parsing errors
        print('Error parsing date/time: $e');
      }
    });
  }

  final RxList<String> itemsLiDo = [
    'Bận việc đột suất',
    'Khách hàng yêu cầu huỷ',
    'Lý do khác',
  ].obs;
  var textLido = "".obs;
  var textEditNoteKhac = TextEditingController();
  void puttComplete(String id) async {
    try {
      final response = await _apiHelper.putComplete(id: id);
      if (response['detail'] == "OK") {
        getCalendarr();
        orderStatuss.value = 4;
        return Utils.showSnackbar(
            message: 'Hoàn tất công việc hãy chờ khác hàng xác nhận',
            icon: AppImages.iconCircleCheck,
            colors: AppColors.kSuccess600Color);
      } else {}
    } catch (e) {
      debugPrint('Error in getPendingInvoicee: $e');
    }
  }

  Future<void> putHuy(Jobs model) async {
    
    try {
      String note = "";
      if (textEditNoteKhac.text.isEmpty) {
        note = textLido.value;
      } else {
        note = textEditNoteKhac.text;
      }
      print(note);

      final response = await _apiHelper.putCancelJob(
        Stt: 1,
        price: int.parse(model.price.toString()),
        idInvoiceDetails: model.idID.toString(),
        idU: model.idU.toString(),
        reasonCancellation: note,
      );
      if (response['detail'] == "OK") {
        getCalendarr();
        previousCurrentIndex.value = 0;
        Get.back();
        Get.back();
        Get.back();
        return Utils.showSnackbar(
            message: 'Hủy việc thành công',
            icon: AppImages.iconCircleCheck,
            colors: AppColors.kSuccess600Color);
      }
    } catch (e) {
      debugPrint('Error in getPendingInvoicee: $e');
    }
  }

  var idPC = "";
  Future<void> postCreateChatt(String id) async {
    try {
      final response = await _apiHelper.postCreateChat(id: id);
      if (response['detail'] == 0) {
        idPC = response['id'];
        debugPrint('Tạo cuộc trò chuyện thành công');
      } else if (response['detail'] == -1) {
        idPC = response['id'];
        debugPrint('Cuộc trò chuyện đã tồn tại');
      } else {
        debugPrint('Tạo cuộc trò chuyện thất bại');
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
