import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:partner_3clean/app/modules/widgets/button_widget.dart';

import '../../../../../common/util/exports.dart';
import '../../../../../data/models/wait_confirmation_models/wait_confirmation.dart';
import '../../../../widgets/custom_svg.dart';
import '../../../../widgets/job_details_widget.dart';
import '../../../controllers/wait_confirmation_controller.dart';

class ConfirmDescriptionPage extends StatefulWidget {
  final WaitConfirmationControlelr controller;
  final WaitConfirmation? model;
  final int km;
  const ConfirmDescriptionPage(
      {Key? key, required this.controller, this.model, required this.km})
      : super(key: key);

  @override
  _ConfirmDescriptionPageState createState() => _ConfirmDescriptionPageState();
}

class _ConfirmDescriptionPageState extends State<ConfirmDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGray050Color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        leading: ButtonWidget(
          onTap: () {
            Get.back();
          },
          widget: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Center(
          child: Text(
            'Chi tiết công việc',
            style:
                AppTextStyle.textButtonStyle.copyWith(color: AppColors.black),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Column(
                children: [
                  SizedBox(width: 0.0, height: 8.h),
                  Container(
                    alignment: Alignment.center,
                    height: 52.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border.symmetric(
                          horizontal: BorderSide(
                        color: AppColors.kGray100Color,
                      )),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.model!.acceptJobCount == 0)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomSvg(
                                image: AppImages.iconTimeLine,
                                color: AppColors.kGray500Color,
                                height: 20.h,
                                width: 20.w,
                              ),
                              SizedBox(width: 8.w, height: 0.0),
                              Text(
                                'Chưa có người nhận...',
                                style: AppTextStyle.textbodyStyle.copyWith(
                                  color: AppColors.kGray500Color,
                                ),
                              )
                            ],
                          ),
                        if (widget.model!.acceptJobCount != 0)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomSvg(
                                image: AppImages.iconUserHeart,
                                color: AppColors.kPurplePurpleColor,
                                height: 20.h,
                                width: 20.w,
                              ),
                              SizedBox(width: 8.w, height: 0.0),
                              Text(
                                'Đã có ${widget.model!.acceptJobCount.toString()} người nhận công việc này',
                                style: AppTextStyle.textbodyStyle.copyWith(
                                  color: AppColors.kPurplePurpleColor,
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
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
                          padding: const EdgeInsets.only(
                                  left: 16, top: 16, right: 16)
                              .r,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 170.w,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  Utils.getLabel(int.parse(
                                      widget.model!.label.toString())),
                                  style: AppTextStyle.lableBodyStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16, top: 8, right: 16)
                                  .r,
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
                                    style:
                                        AppTextStyle.textxsmallStyle.copyWith(
                                      color: AppColors.kGray500Color,
                                    ),
                                  ),
                                ],
                              ),
                              ButtonWidget(
                                onTap: () {
                                  Utils.openMap(
                                      double.parse(
                                          widget.model!.lat.toString()),
                                      double.parse(
                                          widget.model!.lng.toString()));
                                },
                                widget: Row(
                                  children: [
                                    Text(
                                      "Xem vị trí",
                                      style: AppTextStyle.textsmallStyle12
                                          .copyWith(
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
                          margin: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16)
                              .r,
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
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8).r,
                                child: Column(
                                  children: [
                                    Text(
                                      'Làm trong',
                                      style: AppTextStyle.textsmallStyle12
                                          .copyWith(
                                              color: AppColors.kGray500Color),
                                    ),
                                    Flexible(
                                      child: Text(
                                        Utils.getHour(
                                            widget.model!.workTime.toString()),
                                        style: AppTextStyle.textButtonStyle
                                            .copyWith(
                                                color:
                                                    AppColors.kGray1000Color),
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
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8).r,
                                child: Column(
                                  children: [
                                    Text(
                                      'Số tiền',
                                      style: AppTextStyle.textsmallStyle12
                                          .copyWith(
                                              color: AppColors.kGray500Color),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${Utils.formatNumber(int.parse(widget.model!.price.toString()))}đ',
                                        style: AppTextStyle.textButtonStyle
                                            .copyWith(
                                                color:
                                                    AppColors.kGray1000Color),
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
                                        style: AppTextStyle.textsmallStyle
                                            .copyWith(
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
                                text: widget.model!.payment_methods == 2
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
            ],
          ),
          Container(
            width: 375.w,
            height: 80.h,
            padding: const EdgeInsets.all(16).r,
            // color: AppColors.amaranth,
            child: Column(
              children: [
                if (widget.controller.isLoading.value == false)
                  Expanded(
                    child: ButtonWidget(
                      colorBackGroud: Colors.white,
                      onTap: () {
                        widget.controller
                            .puttAcceptJob(widget.model!.idAJ.toString());
                      },
                      colorBoder: AppColors.kRrror600Color,
                      text: 'Huỷ nhận việc',
                      boder: true.obs,
                      textStyle: AppTextStyle.textButtonStyle
                          .copyWith(color: AppColors.kRrror600Color),
                    ),
                  ),
                if (widget.controller.isLoading.value == true)
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        height: 45.h,
                        child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.kRrror600Color, size: 30.r)),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.isChecked.value = false;
    super.dispose();
  }
}
