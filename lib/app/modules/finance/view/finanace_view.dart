import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/util/exports.dart';
import '../../notification/exports.dart';
import '../controllers/finance_controller.dart';
import '../empty/wallet_empty.dart';
import '../loading/wallet_loading.dart';
import '../widgets/finance_page.dart';

class FinanaceView extends GetView<FinanceController> {
  const FinanaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Thông tin tài chính', style: AppTextStyle.titleBodyStyle),
          ],
        ),
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: RefreshIndicator(
        onRefresh: () => controller.get3CleanWallett(),
        child: ListView(
          children: [
            controller.obx(
              (state) {
                final model = controller.cleanWalletList[0];
                return FinancePage(
                  controller: controller,
                  model: model,
                );
              },
              onLoading: const Padding(
                padding: EdgeInsets.all(16),
                child: WalletLoading(),
              ),
              onEmpty: const Center(child: WalletEmpty()),
              onError: (error) => Center(
                child: CustomNotFoundWidget(error: error, top: 0.18.sh),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
