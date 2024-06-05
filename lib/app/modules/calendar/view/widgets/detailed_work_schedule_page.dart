import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:partner_3clean/app/modules/calendar/view/widgets/button_circle_widge.dart';

import '../../../../common/util/exports.dart';
import '../../../../common/util/navigator.dart';
import '../../../../data/models/calendar_models/jobs.dart';
import '../../../chat/view/chat_view.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/custom_appbar_widget.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/job_details_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../../controller/calendar_controller.dart';
import 'cancel_job_widget.dart';

class DetailedWorkSchedulePage extends StatefulWidget {
  final CalendarsController controller;
  final Jobs model;

  const DetailedWorkSchedulePage(
      {Key? key, required this.controller, required this.model})
      : super(key: key);

  @override
  _DetailedWorkSchedulePageState createState() =>
      _DetailedWorkSchedulePageState();
}

class _DetailedWorkSchedulePageState extends State<DetailedWorkSchedulePage> {
  @override
  Widget build(BuildContext context) {
    widget.controller.orderStatuss.value =
        int.parse(widget.model.orderStatus.toString());
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: 'Việc đã nhận',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
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
                            const EdgeInsets.only(left: 16, top: 16, right: 16)
                                .r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 170.w,
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                Utils.getLabel(
                                    int.parse(widget.model.label.toString())),
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
                                  // ignore: unnecessary_string_interpolations
                                  "${Utils.getCityFromAddress(widget.model.location.toString())}",
                                  style: AppTextStyle.textxsmallStyle.copyWith(
                                    color: AppColors.kGray500Color,
                                  ),
                                ),
                              ],
                            ),
                            ButtonWidget(
                              onTap: () {
                                Utils.openMap(
                                    double.parse(widget.model.lat.toString()),
                                    double.parse(widget.model.lng.toString()));
                              },
                              widget: Row(
                                children: [
                                  Text(
                                    "Xem vị trí",
                                    style:
                                        AppTextStyle.textsmallStyle12.copyWith(
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
                        margin:
                            const EdgeInsets.only(top: 16, left: 16, right: 16)
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
                                          widget.model.workTime.toString()),
                                      style: AppTextStyle.textButtonStyle
                                          .copyWith(
                                              color: AppColors.kGray1000Color),
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
                                      '${Utils.formatNumber(int.parse(widget.model.price.toString()))}đ',
                                      style: AppTextStyle.textButtonStyle
                                          .copyWith(
                                              color: AppColors.kGray1000Color),
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
                                      style:
                                          AppTextStyle.textsmallStyle.copyWith(
                                        color: AppColors.kGray1000Color,
                                      ),
                                      children: <TextSpan>[
                                        const TextSpan(
                                          text: 'Bắt đầu: ',
                                        ),
                                        TextSpan(
                                          text:
                                              '${widget.model.workingDay}, Từ ${Utils.getHourStart(widget.model.workTime.toString())}',
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
                              text: "${widget.model.location}",
                            ),
                            if (widget.model.employeeNotes != "")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 0.0, height: 12.h),
                                  Text("Ghi chú cho Người làm",
                                      style: AppTextStyle.textbodyStyle),
                                  SizedBox(width: 0.0, height: 4.h),
                                  JobDetailsWidget(
                                    image: AppImages.iconNote,
                                    text: "${widget.model.employeeNotes}",
                                  ),
                                ],
                              ),
                            if (widget.model.petNotes != "")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 0.0, height: 12.h),
                                  Text("Ghi chú cho Thú cưng",
                                      style: AppTextStyle.textbodyStyle),
                                  SizedBox(width: 0.0, height: 4.h),
                                  JobDetailsWidget(
                                    image: AppImages.iconNote,
                                    text: "${widget.model.petNotes}",
                                  ),
                                ],
                              ),
                            SizedBox(width: 0.0, height: 12.h),
                            JobDetailsWidget(
                              image: AppImages.iconWork,
                              color: AppColors.kGray400Color,
                              text: "${widget.model.roomArea}",
                            ),
                            if (widget.model.premiumService == 1)
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
                              image: AppImages.iconsUserLocation,
                              color: AppColors.kGray400Color,
                              text:
                                  "${widget.model.nameUser} - ${widget.model.phoneNumber}",
                            ),
                            SizedBox(width: 0.0, height: 12.h),
                            JobDetailsWidget(
                              image: AppImages.iconMoneyDollarCircle,
                              color: AppColors.kGray400Color,
                              text: widget.model.payment_methods == 2
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
            SizedBox(width: 0.0, height: 9.h),
            Container(
              padding: const EdgeInsets.all(16).r,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(
                    horizontal: BorderSide(
                  color: AppColors.kGray100Color,
                )),
              ),
              child: Column(
                children: [
                  Text(
                    'Chúc bạn hoàn thành tốt công việc.',
                    style: AppTextStyle.lableBodyStyle,
                  ),
                  SizedBox(width: 0.0, height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonCircleWidge(
                        onTap: () {
                          widget.controller
                              .postCreateChatt(widget.model.idU.toString())
                              .then(
                                (value) => Get.to(
                                  () => widget.controller.idPC == ""
                                      ? const SizedBox.shrink()
                                      : ChatView(
                                          idPC: widget.controller.idPC,
                                          name:
                                              widget.model.nameUser.toString(),
                                          image: widget.model.imageU.toString(),
                                          id: widget.model.idU.toString(),
                                          numberPhone: widget.model.phoneNumber
                                              .toString(),
                                        ),
                                ),
                              );
                        },
                        images: AppImages.iconNote,
                        text: 'Chat ngay',
                      ),
                      SizedBox(width: 16.w, height: 0.0),
                      ButtonCircleWidge(
                        onTap: () {
                          Utils.makePhoneCall(
                              widget.model.phoneNumber.toString());
                        },
                        images: AppImages.iconsPhoneFill,
                        text: 'Gọi điện',
                      ),
                    ],
                  )
                ],
              ),
            ),
            Obx(() => Column(
                  children: [
                    // if (widget.controller.orderStatuss != 4)
                    //   if (Utils.ssHou(widget.model.workTime.toString(),
                    //           widget.model.workingDay.toString()) ==
                    //       false)
                        Column(
                          children: [
                            SizedBox(width: 0.0, height: 8.h),
                            ButtonWidget(
                              onTap: () {
                                showBarModalBottomSheet(
                                  expand: false,
                                  context: context,
                                  // backgroundColor: Colors.transparent,
                                  builder: (context) => Padding(
                                    padding: const EdgeInsets.only(
                                            top: 5, right: 16, left: 16)
                                        .r,
                                    child: _LyDoHuyViec(),
                                  ),
                                );
                              },
                              textStyle: AppTextStyle.textButtonStyle
                                  .copyWith(color: AppColors.kRrror600Color),
                              text: 'Xin huỷ việc',
                              colorBackGroud: AppColors.transparent,
                            ),
                          ],
                        ),
                    if (widget.controller.orderStatuss == 4)
                      Column(
                        children: [
                          SizedBox(width: 0.0, height: 8.h),
                          ButtonWidget(
                            onTap: () {},
                            textStyle: AppTextStyle.textButtonStyle
                                .copyWith(color: AppColors.kSuccess600Color),
                            text: 'Chờ thanh toán',
                            colorBackGroud: AppColors.transparent,
                          ),
                        ],
                      ),
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16).r,
        height: widget.controller.orderStatuss == 4 ? 0.h : 106.h,
        child: Obx(
          () => Column(
            children: [
              if (Utils.ssHou(widget.model.workTime.toString(),
                      widget.model.workingDay.toString()) ==
                  true)
                if (widget.controller.orderStatuss != 4)
                  ButtonWidget(
                    onTap: () {
                      widget.controller
                          .puttComplete(widget.model.idID.toString());
                    },
                    text: 'Hoàn tất',
                    height: 48.h,
                  ),
              if (Utils.ssHou(widget.model.workTime.toString(),
                      widget.model.workingDay.toString()) ==
                  false)
                ButtonWidget(
                  colorBackGroud: AppColors.kGray200Color,
                  textStyle: AppTextStyle.textButtonStyle
                      .copyWith(color: AppColors.kGray1000Color),
                  onTap: () {},
                  text: 'Hoàn tất',
                  height: 48.h,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Column _LyDoHuyViec() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Lý do hủy việc',
              style: AppTextStyle.textButtonStyle.copyWith(
                color: AppColors.kGray1000Color,
              ),
            ),
            ButtonWidget(
              onTap: () {
                Get.back();
              },
              widget: SvgPicture.asset(
                AppImages.iconClose,
                width: 24.w,
                height: 24.h,
              ),
              boder: false.obs,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Flexible(
          fit: FlexFit.loose,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.controller.itemsLiDo.length,
            itemBuilder: (context, index) {
              return ButtonWidget(
                onTap: () {
                  widget.controller.textLido.value =
                      widget.controller.itemsLiDo[index];
                  Get.back();
                  if (widget.controller.textLido.value == "Lý do khác") {
                    showBarModalBottomSheet(
                      expand: false,
                      context: context,
                      // backgroundColor: Colors.transparent,
                      builder: (context) => Padding(
                        padding:
                            const EdgeInsets.only(top: 5, right: 16, left: 16)
                                .r,
                        child: _LyDoKhac(),
                      ),
                    );
                  } else {
                    goPresent(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Thông báo',
                            style: AppTextStyle.textButtonStyle
                                .copyWith(color: AppColors.kGray1000Color),
                          ),
                          ButtonWidget(
                            onTap: () {
                              Get.back();
                            },
                            widget: SvgPicture.asset(
                              AppImages.iconClose,
                              width: 24.w,
                              height: 24.h,
                            ),
                            boder: false.obs,
                          )
                        ],
                      ),
                      SizedBox(width: 0.0, height: 25.h),
                      Text(
                        ' Bạn có chắc chắn muốn huỷ?',
                        style: AppTextStyle.textbodyStyle,
                      ),
                      SizedBox(width: 0.0, height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonWidget(
                              onTap: () {
                                Get.back();
                              },
                              colorBackGroud: Colors.white,
                              text: 'Quay lại',
                              boder: true.obs,
                              textStyle: AppTextStyle.textButtonStyle
                                  .copyWith(color: AppColors.kGray1000Color),
                            ),
                          ),
                          SizedBox(width: 16.w, height: 0.0),
                          Expanded(
                            child: ButtonWidget(
                              onTap: () {
                                widget.controller.putHuy(widget.model);
                              },
                              text: 'Đồng ý',
                              boder: false.obs,
                            ),
                          ),
                          SizedBox(width: 16.w, height: 0.0),
                        ],
                      )
                    ]);
                  }
                },
                widget: Container(
                  height: 56.h,
                  padding: const EdgeInsets.all(16).r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12).r,
                    color: AppColors.white,
                    border: Border.all(
                      color: AppColors.kGray300Color,
                    ),
                  ),
                  child: Text(
                    widget.controller.itemsLiDo[index],
                    style: AppTextStyle.lableBodyStyle.copyWith(
                      color: AppColors.kGray1000Color,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
          ),
        ),
      ],
    );
  }

  Column _LyDoKhac() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Lý do hủy việc',
              style: AppTextStyle.textButtonStyle.copyWith(
                color: AppColors.kGray1000Color,
              ),
            ),
            ButtonWidget(
              onTap: () {
                Get.back();
              },
              widget: SvgPicture.asset(
                AppImages.iconClose,
                width: 24.w,
                height: 24.h,
              ),
              boder: false.obs,
            ),
          ],
        ),
        SizedBox(height: 32.h),
        TextFieldWidget(
          controller: widget.controller.textEditNoteKhac,
          obsNhapText: false,
          hintText: 'Nhập lý do hủy',
        ),
        SizedBox(height: 16.h),
        ButtonWidget(
          onTap: () {
            if (widget.controller.textEditNoteKhac.text.isEmpty) {
              return Utils.showSnackbar(
                message: 'Vui lòng nhập lý do trước khi hủy',
                icon: AppImages.iconCircleCheck,
                colors: AppColors.kRrror600Color,
              );
            } else {
              goPresent(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thông báo',
                      style: AppTextStyle.textButtonStyle
                          .copyWith(color: AppColors.kGray1000Color),
                    ),
                    ButtonWidget(
                      onTap: () {
                        Get.back();
                      },
                      widget: SvgPicture.asset(
                        AppImages.iconClose,
                        width: 24.w,
                        height: 24.h,
                      ),
                      boder: false.obs,
                    )
                  ],
                ),
                SizedBox(width: 0.0, height: 25.h),
                Text(
                  ' Bạn có chắc chắn muốn huỷ?',
                  style: AppTextStyle.textbodyStyle,
                ),
                SizedBox(width: 0.0, height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        onTap: () {
                          Get.back();
                        },
                        colorBackGroud: Colors.white,
                        text: 'Quay lại',
                        boder: true.obs,
                        textStyle: AppTextStyle.textButtonStyle
                            .copyWith(color: AppColors.kGray1000Color),
                      ),
                    ),
                    SizedBox(width: 16.w, height: 0.0),
                    Expanded(
                      child: ButtonWidget(
                        onTap: () {
                          widget.controller.putHuy(widget.model);
                        },
                        text: 'Đồng ý',
                        boder: false.obs,
                      ),
                    ),
                    SizedBox(width: 16.w, height: 0.0),
                  ],
                )
              ]);
            }
          },
          text: 'Đồng ý',
        ),
      ],
    );
  }
}
