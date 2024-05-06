import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:partner_3clean/app/modules/widgets/custom_appbar_widget.dart';

import '../../../common/util/exports.dart';
import '../../../data/models/clean_wallet_models/clean_wallet.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_svg.dart';
import '../controllers/finance_controller.dart';
import '../empty/wallet_empty.dart';
import '../transaction_history/transaction_history.dart';

class FinancePage extends StatelessWidget {
  final FinanceController controller;
  final CleanWallet model;
  const FinancePage({Key? key, required this.controller, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16).r,
          child: Container(
            width: 343.w,
            height: 136.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12).r,
              border: Border.all(color: AppColors.kGray100Color),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.04),
                  offset: const Offset(0, 4),
                  blurRadius: 6.r,
                  spreadRadius: -2.r,
                ),
                BoxShadow(
                  color: AppColors.black.withOpacity(0.08),
                  offset: const Offset(0, 4),
                  blurRadius: 15.r,
                  spreadRadius: -3.r,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14).r,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 223.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Số dư khả dụng',
                              style: AppTextStyle.textsmallStyle12
                                  .copyWith(color: AppColors.kGray500Color),
                            ),
                            Text(
                                '${Utils.formatNumber(int.parse(model.moneyP.toString()))}đ',
                                style: AppTextStyle.titleBodyStyle28),
                          ],
                        ),
                      ),
                      ButtonWidget(
                        onTap: () {},
                        widget: Container(
                          alignment: Alignment.center,
                          width: 82.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: AppColors.kButtonColor,
                            borderRadius: BorderRadius.circular(8).r,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomSvg(
                                image: AppImages.iconWallet,
                                width: 16.w,
                                height: 16.h,
                                color: AppColors.white,
                              ),
                              Text(
                                "Rút tiền",
                                style: AppTextStyle.textsmallStyle12
                                    .copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.h,
                  color: AppColors.kGray100Color,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16)
                          .r,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Thông tin chi tiết',
                          style: AppTextStyle.textbodyStyle,
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 0.0, height: 0.0),
                            SizedBox(width: 10.w, height: 0.0),
                            const CustomSvg(
                              image: AppImages.iconArrowright,
                              fit: BoxFit.fitHeight,
                              color: AppColors.kGray400Color,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 0.0, height: 22.h),
        SizedBox(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lịch Sử giao dịch',
                      style: AppTextStyle.largeBodyStyle,
                    ),
                    ButtonWidget(
                      onTap: () {
                        Get.to(() => const TransactionHistory(),
                            arguments: model);
                      },
                      widget: Container(
                        width: 40.w,
                        height: 40.h,
                        padding: const EdgeInsets.all(8).r,
                        decoration: BoxDecoration(
                          color: AppColors.kWarning050Color,
                          borderRadius: BorderRadius.circular(40).r,
                        ),
                        child: const CustomSvg(
                          image: AppImages.iconArrowright,
                          fit: BoxFit.fitHeight,
                          color: AppColors.kPurplePurpleColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (model.wallet!.isNotEmpty)
                SingleChildScrollView(
                  child: SizedBox(
                    height: 400.h,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: model.wallet!.length,
                      itemBuilder: (context, index) {
                        final models = model.wallet![index];
                        return Padding(
                          padding: const EdgeInsets.all(16).r,
                          child: Row(
                            children: [
                              Container(
                                width: 24.w,
                                height: 24.h,
                                padding: const EdgeInsets.all(4).r,
                                decoration: BoxDecoration(
                                  color: models.status == 0
                                      ? AppColors.kGray500Color
                                      : models.status == 1
                                          ? AppColors.kRrror600Color
                                          : AppColors.kSuccess600Color,
                                  borderRadius: BorderRadius.circular(24).r,
                                ),
                                child: CustomSvg(
                                  image: models.status == 0
                                      ? AppImages.iconMoneyDollarBox
                                      : models.status == 1
                                          ? AppImages.iconsMoneyDollarCircleFill
                                          : AppImages.iconsWalletPlusFill,
                                  fit: BoxFit.fitHeight,
                                  color: AppColors.white,
                                  width: 16.w,
                                  height: 16.h,
                                ),
                              ),
                              SizedBox(width: 8.w, height: 0.0),
                              SizedBox(
                                width: 199.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      models.note.toString(),
                                      style: AppTextStyle.textsmallStyle,
                                    ),
                                    SizedBox(width: 4.w, height: 0.0),
                                    Text(
                                      Utils.formatDateTimeString(
                                          models.date.toString()),
                                      style: AppTextStyle.textxsmallStyle
                                          .copyWith(
                                              color: AppColors.kGray500Color),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 104.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      models.status == 0 || models == 1
                                          ? '-${Utils.formatNumber(int.parse(models.moneyBF.toString()))}đ'
                                          : '+${Utils.formatNumber(int.parse(models.moneyBF.toString()))}đ',
                                      style: AppTextStyle.textbodyStyle,
                                    ),
                                    SizedBox(width: 4.w, height: 0.0),
                                    Text(
                                      models.wallet.toString(),
                                      style: AppTextStyle.textxsmallStyle
                                          .copyWith(
                                              color: AppColors.kGray500Color),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Container(
                        height: 1.h,
                        color: AppColors.kGray100Color,
                      ),
                    ),
                  ),
                ),
              if (model.wallet!.isEmpty)
                SizedBox(
                  height: 400.h,
                  child: const WalletEmpty(),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
