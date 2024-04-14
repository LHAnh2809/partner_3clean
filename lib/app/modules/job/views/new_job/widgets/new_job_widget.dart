import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:partner_3clean/app/data/models/job_all_models/job_all.dart';

import '../../../../../common/util/exports.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/custom_svg.dart';
import '../../../../widgets/job_details_widget.dart';
import '../../../controllers/job_all_controller.dart';
import '../job_description/job_description_page.dart';
import '../../see_location/see_location_page.dart';

class NewJobWidget extends StatelessWidget {
  final JobAllController controller;
  final JobAll? model;
  final int km;
  const NewJobWidget({
    Key? key,
    required this.model,
    required this.controller,
    required this.km,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.kGray100Color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 170.w,
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    Utils.getLabel(int.parse(model!.label.toString())),
                    style: AppTextStyle.lableBodyStyle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, right: 16).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomSvg(
                      image: AppImages.iconsMapPin4Fill,
                      fit: BoxFit.cover,
                      color: AppColors.kGray1000Color,
                      width: 16.w,
                      height: 16.h,
                    ),
                    SizedBox(width: 4.w, height: 0.0),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      "${Utils.getCityFromAddress(model!.location.toString())} • Khoảng cách ${km.toString()} km",
                      style: AppTextStyle.textxsmallStyle.copyWith(
                        color: AppColors.kGray500Color,
                      ),
                    ),
                  ],
                ),
                ButtonWidget(
                  onTap: () {
                    Utils.openMap(double.parse(model!.lat.toString()),
                        double.parse(model!.lng.toString()));
                  },
                  widget: Row(
                    children: [
                      Text(
                        "Xem vị trí",
                        style: AppTextStyle.textsmallStyle12.copyWith(
                          color: AppColors.kPurplePurpleColor,
                        ),
                      ),
                      Icon(
                        Ionicons.chevron_forward_outline,
                        size: 12.5.sp,
                        color: AppColors.kPurplePurpleColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 343.w,
            height: 60.h,
            margin: const EdgeInsets.only(top: 16, left: 16, right: 16).r,
            padding: const EdgeInsets.only(left: 8, right: 8).r,
            decoration: BoxDecoration(
              color: AppColors.kGray050Color,
              borderRadius: BorderRadius.circular(8).r,
              border: Border.all(color: AppColors.kGray200Color),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8).r,
                  child: Column(
                    children: [
                      Text(
                        'Làm trong',
                        style: AppTextStyle.textsmallStyle12
                            .copyWith(color: AppColors.kGray500Color),
                      ),
                      Flexible(
                        child: Text(
                          Utils.getHour(model!.workTime.toString()),
                          style: AppTextStyle.textButtonStyle
                              .copyWith(color: AppColors.kGray1000Color),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1.w,
                  color: AppColors.kGray200Color,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8).r,
                  child: Column(
                    children: [
                      Text(
                        'Số tiền',
                        style: AppTextStyle.textsmallStyle12
                            .copyWith(color: AppColors.kGray500Color),
                      ),
                      Flexible(
                        child: Text(
                          '${Utils.formatNumber(int.parse(model!.price.toString()))}đ',
                          style: AppTextStyle.textButtonStyle
                              .copyWith(color: AppColors.kGray1000Color),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16).r,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: SvgPicture.asset(
                        AppImages.iconTime,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12.w, height: 0.0),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyle.textsmallStyle.copyWith(
                            color: AppColors.kGray1000Color,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Bắt đầu: ',
                            ),
                            TextSpan(
                              text:
                                  '${model!.workingDay}, Từ ${Utils.getHourStart(model!.workTime.toString())}',
                              style: AppTextStyle.textbodyStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 0.0, height: 12.h),
                JobDetailsWidget(
                  image: AppImages.iconLocation2,
                  text: "${model!.location}",
                ),
                if (model!.employeeNotes != "")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 0.0, height: 12.h),
                      Text("Ghi chú cho Người làm",
                          style: AppTextStyle.textbodyStyle),
                      SizedBox(width: 0.0, height: 4.h),
                      JobDetailsWidget(
                        image: AppImages.iconNote,
                        text: "${model!.employeeNotes}",
                      ),
                    ],
                  ),
                if (model!.petNotes != "")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 0.0, height: 12.h),
                      Text("Ghi chú cho Thú cưng",
                          style: AppTextStyle.textbodyStyle),
                      SizedBox(width: 0.0, height: 4.h),
                      JobDetailsWidget(
                        image: AppImages.iconNote,
                        text: "${model!.petNotes}",
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Container(
            color: AppColors.kGray100Color,
            height: 1.h,
          ),
          Padding(
              padding: const EdgeInsets.all(16).r,
              child: ButtonWidget(
                onTap: () {
                  Get.to(() => JobDescriptionPage(
                        controller: controller,
                        model: model,
                        km: km,
                      ));
                },
                widget: Center(
                  child: Text(
                    'Xem mô tả công việc',
                    style: AppTextStyle.textbodyStyle.copyWith(
                      color: AppColors.kPurplePurpleColor,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
