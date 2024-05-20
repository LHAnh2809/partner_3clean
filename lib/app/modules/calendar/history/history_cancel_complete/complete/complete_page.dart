import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/util/exports.dart';
import '../../../../../data/models/cancel_complete_history_models/cancel_complete_history.dart';
import '../../../../notification/exports.dart';
import '../../../../widgets/custom_empty_widget.dart';
import '../../../../widgets/job_details_widget.dart';
import '../../../controller/history_controller.dart';

class CompletePage extends StatelessWidget {
  final HistoryController controller;
  const CompletePage({Key? key,  required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: RefreshIndicator(
          onRefresh: () => controller.getCancellationJobHistory(),
          child: ListView(
              // physics: const ClampingScrollPhysics(),
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16).r,
                  child: controller.obx(
                    (state) {
                      final List<CancelCompleteHistory> models = state ?? [];
                      bool hasItemsToShow = false;

                      // Kiểm tra xem danh sách có mục thỏa mãn điều kiện hay không
                      for (final model in models) {
                        if (model.orderStatus == 5 || model.orderStatus == 6) {
                          hasItemsToShow = true;
                          break;
                        }
                      }
                      if (hasItemsToShow) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: models.length,
                          itemBuilder: (BuildContext context, int index) {
                            final CancelCompleteHistory model = models[index];
                            if (model.orderStatus == 5 ||
                                model.orderStatus == 6) {
                              return Container(
                                padding: const EdgeInsets.all(16).r,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(12).r,
                                  border: Border.all(
                                      color: AppColors.kGray200Color),
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
                                    Text(
                                      Utils.getLabel(
                                          int.parse(model.label.toString())),
                                      style: AppTextStyle.lableBodyStyle,
                                    ),
                                    SizedBox(width: 0.0, height: 12.h),
                                    JobDetailsWidget(
                                      image: AppImages.iconTime,
                                      text:
                                          // ignore: unnecessary_string_interpolations
                                          '${Utils.getHourDateStart(model.workTime.toString(), model.workingDay.toString())}',
                                      textStyle: AppTextStyle.textbodyStyle,
                                    ),
                                    SizedBox(width: 0.0, height: 12.h),
                                    JobDetailsWidget(
                                      image: AppImages.iconLocation2,
                                      text:
                                          "${model.location2}, ${model.location}",
                                      textStyle: AppTextStyle.textsmallStyle,
                                    ),
                                    SizedBox(width: 0.0, height: 12.h),
                                    Container(
                                      height: 1.h,
                                      color: AppColors.kGray100Color,
                                    ),
                                    SizedBox(width: 0.0, height: 12.h),
                                    JobDetailsWidget(
                                      image: AppImages.iconTime,
                                      textStyle: AppTextStyle.textsmallStyle,
                                      textWidget: RichText(
                                        text: TextSpan(
                                          style: AppTextStyle.textsmallStyle,
                                          children: <TextSpan>[
                                          const  TextSpan(
                                              text: "Hoàn thành vào lúc: "
                                                  ,
                                            ),
                                            TextSpan(
                                              text: model
                                                  .cancellationIimeCompleted,
                                              style: AppTextStyle.textbodyStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox
                                  .shrink(); // Or you can return null
                            }
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 0.0, height: 8.h),
                        );
                      } else {
                        // Hiển thị widget trống nếu không có mục nào thỏa mãn điều kiện
                        return Center(child: CustomEmptyWidget(top: 0.12.sh));
                      }
                    },
                    onLoading: const LoadingPage(),
                    onEmpty: Center(child: CustomEmptyWidget(top: 0.12.sh)),
                    onError: (error) => Center(
                        child:
                            CustomNotFoundWidget(error: error, top: 0.18.sh)),
                  ),
                )
              ]),
        ));
  }
}
