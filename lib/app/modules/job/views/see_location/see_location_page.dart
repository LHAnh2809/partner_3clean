import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

import '../../../../common/util/exports.dart';
import '../../controllers/sen_location_controller.dart';

class SeeLocationPage extends StatelessWidget {
  SeeLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SenLocationController controller = Get.put(SenLocationController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Chào các bạn'),
      ),
      body: Stack(
        children: [
          VietmapGL(
            onMapCreated: (value) {
              controller.mapController.value = value;
            },
            trackCameraPosition: true,
            myLocationEnabled: true,
            myLocationRenderMode: MyLocationRenderMode.COMPASS,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
            initialCameraPosition: const CameraPosition(
                target: LatLng(18.4203656, 105.5388458), zoom: 7),
            styleString: Vietmap.getVietmapStyleUrl(),
          ),
          Obx(() {
            return controller.mapController.value == null
                ? const SizedBox.shrink()
                : MarkerLayer(
                    markers: [
                      Marker(
                        alignment: Alignment.bottomCenter,
                        width: 50.w,
                        height: 50.h,
                        child: Icon(
                          Icons.location_on,
                          color: AppColors.kRrror600Color,
                          size: 50.sp,
                        ),
                        latLng: LatLng(18.4203656, 105.5388458),
                      )
                    ],
                    mapController: controller.mapController.value!,
                  );
          }),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // controller.mapController.value?.addPolyline(
              //   PolylineOptions(
              //     geometry: [
              //       LatLng(18.4203656, 105.5888458),
              //       LatLng(18.4103656, 105.5388458),
              //       LatLng(18.4003656, 105.5288458),
              //     ],
              //     polylineColor: AppColors.kPurplePurpleColor,
              //     polylineWidth: 10.sp,
              //   ),
              // );
            },
            tooltip: 'Das',
            child: const Icon(Icons.list),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            tooltip: 'Das t',
            onPressed: () async {},
            child: const Icon(Icons.location_on),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
