import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/common/util/exports.dart';
import 'package:partner_3clean/app/common/util/utils.dart';
import 'package:partner_3clean/app/modules/widgets/button_widget.dart';
import 'package:partner_3clean/app/modules/widgets/custom_appbar_widget.dart';
import 'package:partner_3clean/app/modules/widgets/text_field_widget.dart';

import '../../widgets/custom_svg.dart';
import 'controllers/chat_controller.dart';

class ChatView extends StatefulWidget {
  final String name;
  final String image;
  final String id;
  final String numberPhone;
  final String idPC;
  const ChatView(
      {Key? key,
      required this.name,
      required this.image,
      required this.id,
      required this.numberPhone,
      required this.idPC})
      : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatController controller = Get.put(ChatController());
  @override
  void initState() {
    controller.connect(widget.idPC);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppbarWidget(
          centerTitle: false,
          titleWidget: Row(
            children: [
              if (widget.image != "")
                CircleAvatar(
                  radius: 18.r,
                  backgroundImage: NetworkImage(widget.image),
                ),
              if (widget.image == "")
                Stack(
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: AppColors.kGray200Color,
                        shape: BoxShape.circle,
                        border: Border.all(width: 3),
                      ),
                      child: SvgPicture.asset(
                        AppImages.iconAvtUser,
                        fit: BoxFit.cover,
                        width: 41.w,
                        height: 41.h,
                      ),
                    ),
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: AppColors.kGray200Color,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(width: 8.w, height: 0.0),
              Text(
                widget.name,
                style: AppTextStyle.textsmallStyle12,
              ),
            ],
          ),
          actions: [
            ButtonWidget(
              onTap: () {
                Utils.makePhoneCall(widget.numberPhone);
              },
              widget: Container(
                width: 32.w,
                height: 32.h,
                padding: const EdgeInsets.all(8).r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColors.kBrightPurpleColor,
                      AppColors.kDarkPurpleColor,
                    ],
                  ),
                ),
                child: const CustomSvg(
                  image: AppImages.iconsPhoneFill,
                  color: AppColors.white,
                ),
              ),
            ).paddingOnly(right: 10.w),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16).r,
          child: Column(
            children: [
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    controller: controller.scrollController,
                    reverse: true,
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final message = controller
                          .messages[controller.messages.length - 1 - index];
                      return Column(
                        crossAxisAlignment:
                            controller.idUser == message.idNguoiGui
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => controller.selectedMessageId.value ==
                                    message.id
                                ? Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          Utils.formattedTime(message.thoiGian),
                                          style: AppTextStyle.textxsmallStyle
                                              .copyWith(
                                            color: AppColors.kGray400Color,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 0.0, height: 4.h),
                                    ],
                                  )
                                : SizedBox.shrink(),
                          ),
                          Row(
                            mainAxisAlignment:
                                controller.idUser == message.idNguoiGui
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              ButtonWidget(
                                onTap: () {
                                  controller.selectMessage(message.id);
                                },
                                widget: Container(
                                  padding: const EdgeInsets.all(8).r,
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.8,
                                  ),
                                  decoration: controller.idUser ==
                                          message.idNguoiGui
                                      ? BoxDecoration(
                                          color: AppColors.kGray100Color,
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(8).r,
                                            bottomRight:
                                                const Radius.circular(8).r,
                                            bottomLeft:
                                                const Radius.circular(8).r,
                                          ),
                                        )
                                      : BoxDecoration(
                                          color: AppColors.kPurple050Color,
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(8).r,
                                            topRight:
                                                const Radius.circular(8).r,
                                            bottomRight:
                                                const Radius.circular(8).r,
                                          ),
                                        ),
                                  child: Text(
                                    message.noiDung,
                                    style: AppTextStyle.textsmallStyle,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 0.0, height: 16.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: controller.chat,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15).r,
                        borderSide: const BorderSide(
                          color: AppColors.kGray200Color,
                        ),
                      ),
                      obsNhapText: false,
                      hintText: 'Soạn tin nhắn...',
                      onChanged: (value) {
                        controller.textChat.value = value;
                      },
                    ),
                  ),
                  Obx(
                    () => controller.textChat.value != ""
                        ? ButtonWidget(
                            onTap: () {
                              controller.sendMessage();
                            },
                            widget: Container(
                              width: 32.w,
                              height: 32.h,
                              padding: const EdgeInsets.all(6).r,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    AppColors.kBrightPurpleColor,
                                    AppColors.kDarkPurpleColor,
                                  ],
                                ),
                              ),
                              child: const CustomSvg(
                                image: AppImages.iconsSendPlaneFill,
                                color: AppColors.white,
                              ),
                            ),
                          ).paddingOnly(left: 10.w)
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
