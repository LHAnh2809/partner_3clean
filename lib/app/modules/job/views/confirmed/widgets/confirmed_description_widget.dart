import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:partner_3clean/app/modules/job/controllers/confirmed_controller.dart';

import '../../../../../common/util/exports.dart';
import '../../../../../data/models/determined_models/determined.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/custom_appbar_widget.dart';
import '../../../../widgets/custom_svg.dart';
import '../../../../widgets/job_details_widget.dart';

class ConfirmedDescriptionWidget extends StatefulWidget {
  final ConfirmedController controller;
  final Determined? model;
  final int km;
  const ConfirmedDescriptionWidget(
      {Key? key, required this.controller, this.model, required this.km})
      : super(key: key);

  @override
  _ConfirmedDescriptionWidgetState createState() =>
      _ConfirmedDescriptionWidgetState();
}

class _ConfirmedDescriptionWidgetState
    extends State<ConfirmedDescriptionWidget> {
  @override
  void dispose() {
    widget.controller.isChecked.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGray050Color,
      appBar: CustomAppbarWidget(
        title: 'Chi tiết công việc',
      ),
      body: Column(
        children: [
          SizedBox(width: 0.0, height: 8.h),
          Container(
            // margin: const EdgeInsets.all(16).r,
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                  horizontal: BorderSide(
                color: AppColors.kGray100Color,
              )),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, top: 16, right: 16).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          Utils.getLabel(
                              int.parse(widget.model!.label.toString())),
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
                            "${Utils.getCityFromAddress(widget.model!.location.toString())} • Khoảng cách ${widget.km.toString()} km",
                            style: AppTextStyle.textxsmallStyle.copyWith(
                              color: AppColors.kGray500Color,
                            ),
                          ),
                        ],
                      ),
                      ButtonWidget(
                        onTap: () {
                          Utils.openMap(
                              double.parse(widget.model!.lat.toString()),
                              double.parse(widget.model!.lng.toString()));
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
                                Utils.getHour(
                                    widget.model!.workTime.toString()),
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
                                '${Utils.formatNumber(int.parse(widget.model!.price.toString()))}đ',
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
                                        '${widget.model!.workingDay}, Từ ${Utils.getHourStart(widget.model!.workTime.toString())}',
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
                        text: "${widget.model!.location}",
                      ),
                      if (widget.model!.employeeNotes != "")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 0.0, height: 12.h),
                            Text("Ghi chú cho Người làm",
                                style: AppTextStyle.textbodyStyle),
                            SizedBox(width: 0.0, height: 4.h),
                            JobDetailsWidget(
                              image: AppImages.iconNote,
                              text: "${widget.model!.employeeNotes}",
                            ),
                          ],
                        ),
                      if (widget.model!.petNotes != "")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 0.0, height: 12.h),
                            Text("Ghi chú cho Thú cưng",
                                style: AppTextStyle.textbodyStyle),
                            SizedBox(width: 0.0, height: 4.h),
                            JobDetailsWidget(
                              image: AppImages.iconNote,
                              text: "${widget.model!.petNotes}",
                            ),
                          ],
                        ),
                      SizedBox(width: 0.0, height: 12.h),
                      JobDetailsWidget(
                        image: AppImages.iconWork,
                        color: AppColors.kGray400Color,
                        text: "${widget.model!.roomArea}",
                      ),
                      if (widget.model!.premiumService == 1)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 0.0, height: 12.h),
                            const JobDetailsWidget(
                              image: AppImages.iconVipCrown2,
                              color: AppColors.kGray400Color,
                              text: "Dịch vụ Premium",
                            ),
                          ],
                        ),
                      SizedBox(width: 0.0, height: 12.h),
                      JobDetailsWidget(
                        image: AppImages.iconMoneyDollarCircle,
                        color: AppColors.kGray400Color,
                        text: widget.model!.paymentMethods == 2
                            ? "Thanh toán qua ví 3Clean"
                            : 'Thanh toán bằng tiền mặt',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
