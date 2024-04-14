import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../../data/models/wait_confirmation_models/wait_confirmation.dart';
import '../../../notification/views/loading/loading_page.dart';
import '../../../widgets/custom_empty_widget.dart';
import '../../../widgets/custom_not_found_widget.dart';
import '../../controllers/wait_confirmation_controller.dart';
import 'widgets/wait_confirmation_widget.dart';

class WaitConfirmationPage extends GetView<WaitConfirmationControlelr> {
  const WaitConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () => controller.gettWaitConfirmation(),
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
                      final WaitConfirmation? model =
                          state![index] as WaitConfirmation?;
                      var km = (Geolocator.distanceBetween(
                                  double.parse(model!.lat.toString()),
                                  double.parse(model.lng.toString()),
                                  double.parse(controller.textLat.toString()),
                                  double.parse(controller.textLng.toString())) /
                              1000)
                          .truncate();

                      return WaitConfirmationWidget(
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
