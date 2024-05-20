import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/clean_wallet_models/clean_wallet.dart';
import '../../../data/models/statistics_models/statistics.dart';
import '../../../data/repository/api_helper.dart';

class FinanceController extends GetxController with StateMixin<CleanWallet> {
  final ApiHelper _apiHelper = Get.find();
  DateTime now = DateTime.now();
  @override
  void onInit() {
    get3CleanWallett();
    getStatisticss(now);
    super.onInit();
  }

  List<CleanWallet> cleanWalletList = [];
  RxList<Statistics> listStatistics = <Statistics>[].obs;

  Future<void> get3CleanWallett() async {
    try {
      change(null, status: RxStatus.loading());

      final response = await _apiHelper.get3cleanWallet();

      if (response['status'] == "OK") {
        final CleanWallet cleanWallet =
            CleanWallet.fromJson(response['3clean_wallet']);

        cleanWalletList = [cleanWallet];
        change(cleanWallet, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      print(e.toString());
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  // Lưu trữ ngày bắt đầu của tuần hiện tại
  Rx<DateTime> currentWeekStart =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).obs;

  // Hàm để chuyển sang tuần tiếp theo (chỉ cho phép tới tuần hiện tại)
  void nextWeek() {
    DateTime nextWeekStart = currentWeekStart.value.add(Duration(days: 7));
    if (nextWeekStart.isBefore(
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)))) {
      currentWeekStart.value = nextWeekStart;
    }
  }

  // Hàm để quay lại tuần trước
  void previousWeek() {
    currentWeekStart.value = currentWeekStart.value.subtract(Duration(days: 7));
  }

  // Hàm để định dạng ngày
  String formatDate(DateTime date) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  // Hàm để lấy ngày cuối của tuần
  DateTime getEndOfWeek(DateTime startOfWeek) {
    return startOfWeek.add(Duration(days: 6));
  }

  // Hàm để lấy ngày đầu và cuối của tuần trước
  DateTime getStartOfLastWeek(DateTime startOfWeek) {
    return startOfWeek.subtract(Duration(days: 7));
  }

  DateTime getEndOfLastWeek(DateTime endOfWeek) {
    return endOfWeek.subtract(Duration(days: 7));
  }

  var isLoading = false.obs;

  Future<void> getStatisticss(DateTime startOfWeeks) async {
    // Tính toán ngày đầu tiên và cuối của tuần này
    DateTime startOfWeek =
        startOfWeeks.subtract(Duration(days: startOfWeeks.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    // Tính toán ngày đầu tiên và cuối của tuần trước
    DateTime startOfLastWeek = startOfWeek.subtract(Duration(days: 7));
    DateTime endOfLastWeek = endOfWeek.subtract(Duration(days: 7));

    // Định dạng ngày
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedStartOfWeek = formatter.format(startOfWeek);
    String formattedEndOfWeek = formatter.format(endOfWeek);
    String formattedStartOfLastWeek = formatter.format(startOfLastWeek);
    String formattedEndOfLastWeek = formatter.format(endOfLastWeek);

    print('Ngày đầu tiên của tuần này: $formattedStartOfWeek');
    print('Ngày cuối của tuần này: $formattedEndOfWeek');
    print('Ngày đầu tiên của tuần trước: $formattedStartOfLastWeek');
    print('Ngày cuối của tuần trước: $formattedEndOfLastWeek');

    try {
      final response = await _apiHelper.getStatistics(
        startDate1: formattedStartOfWeek,
        endDate1: formattedEndOfWeek,
        startDate2: formattedStartOfLastWeek,
        endDate2: formattedEndOfLastWeek,
      );

      if (response['status'] == "OK") {
        final List<dynamic> statisticsList = response['statistics'];
        final List<Statistics> listStatisticsS =
            statisticsList.map((stat) => Statistics.fromJson(stat)).toList();
        listStatistics.value = listStatisticsS;
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }
}
