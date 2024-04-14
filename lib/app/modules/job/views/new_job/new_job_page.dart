import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/modules/job/views/new_job/widgets/new_job_widget.dart';
import '../../../../common/util/exports.dart';
import '../../../../data/models/job_all_models/job_all.dart';
import '../../../notification/exports.dart';
import '../../../widgets/custom_empty_widget.dart';
import '../../controllers/job_all_controller.dart';

class NewJobPage extends GetView<JobAllController> {
  const NewJobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () => controller.getJobAll(),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(
                      left: 16, top: 16, right: 16, bottom: 16)
                  .r,
              child: controller.obx(
                (state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final JobAll? model = state![index] as JobAll?;
                      var km = (Geolocator.distanceBetween(
                                  double.parse(model!.lat.toString()),
                                  double.parse(model.lng.toString()),
                                  double.parse(controller.textLat.toString()),
                                  double.parse(controller.textLng.toString())) /
                              1000)
                          .truncate();

                      return NewJobWidget(
                        model: model,
                        controller: controller,
                        km: km,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(width: 0.0, height: 8.h),
                  );
                },
                onLoading: const LoadingPage(),
                onEmpty: Center(child: CustomEmptyWidget(top: 0.12.sh)),
                onError: (error) => Center(
                    child: CustomNotFoundWidget(error: error, top: 0.18.sh)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
