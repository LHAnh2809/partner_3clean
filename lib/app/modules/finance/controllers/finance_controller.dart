import 'package:get/get.dart';

import '../../../data/models/clean_wallet_models/clean_wallet.dart';
import '../../../data/repository/api_helper.dart';

class FinanceController extends GetxController with StateMixin<CleanWallet> {
  final ApiHelper _apiHelper = Get.find();
  @override
  void onInit() {
    get3CleanWallett();
    super.onInit();
  }

  List<CleanWallet> cleanWalletList = [];

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
}
