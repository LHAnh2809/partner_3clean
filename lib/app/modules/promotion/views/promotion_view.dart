import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/modules/promotion/exports.dart';

import 'package:partner_3clean/app/modules/widgets/button_all_widget.dart';

import '../../../common/util/exports.dart';

class PromotionView extends GetView<PromotionController> {
  const PromotionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderWidget(
            controller: controller,
            onTap: () {},
          ),
          const ButtonHistoryBenefitsWidget(),
          SizedBox(width: 0.0, height: 10.h),
          Container(
            height: 1.5,
            color: const Color.fromARGB(57, 0, 0, 0),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20).r,
            color: AppColors.kGreyChart,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                          .r,
                  child: ButtonAllWidget(
                    onTap: () {},
                    color: AppColors.kGreyChart,
                    text: Strings.yourCoupon,
                    fontSize: 14.5.sp,
                    colorText: Colors.black,
                  ),
                ),
                YourOfferWidget(
                  controller: controller,
                ),
                DiscountBustBuster(
                  controller: controller,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
