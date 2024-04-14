import 'package:get/get.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

import '../../../common/constants.dart';

class SenLocationController extends GetxController {
  Rx<VietmapController?> mapController = Rx<VietmapController?>(null);
  final List<Marker> nearbyMarker = [];

  @override
  void onInit() {
    /// Must call this method before using Vietmap APIs.
    Vietmap.getInstance(Constants.apiKeyVietMap);
    super.onInit();
  }

  Future<void> incrementCounter() async {
    // var res = await Vietmap.reverse(const LatLng(21.027763, 105.834160));

    Vietmap.autocomplete(VietMapAutoCompleteParams(textSearch: 'Hà Nội'));
    Vietmap.geoCode(VietMapAutoCompleteParams(textSearch: 'Hà Nội'));
    Vietmap.reverse(const LatLng(21.027763, 105.834160));
    Vietmap.place('Place ID');
    var routingResponse = await Vietmap.routing(VietMapRoutingParams(points: [
      const LatLng(10.779391, 106.624833),
      const LatLng(10.741039, 106.672116)
    ]));
    routingResponse.fold((Failure failure) {
      // handle failure here
    }, (VietMapRoutingModel success) {
      if (success.paths?.isNotEmpty == true &&
          success.paths![0].points?.isNotEmpty == true) {}
    });
    Vietmap.getVietmapStyleUrl();
  }
}
