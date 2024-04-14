import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:partner_3clean/app/common/util/exports.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScreenState();
}

class _ScreenState extends State<QrScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isSanScan = true;
  XFile? cardImage;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          _buildQrView(context),
          _buildIconBack(),
          _buildTextDescription(),
          // _buildIconFlash()
        ],
      ),
    );
  }

  _buildTextDescription() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 100,
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 18.h),
        child: Text(
          'Bạn vui lòng quét mã Qr thẻ Căn cước công dân gắn chip',
          textAlign: TextAlign.center,
          style: AppTextStyle.textsmallStyle.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  _buildIconBack() {
    return Positioned(
        left: 0,
        top: 40,
        child: MaterialButton(
          onPressed: () {
            Get.back();
          },
          color: Colors.white,
          textColor: Colors.white,
          child: Icon(
            Icons.arrow_back,
            size: 18.sp,
            color: Colors.black,
          ),
          padding: EdgeInsets.all(1.w),
          shape: const CircleBorder(),
        ));
  }

  _buildIconFlash() {
    return Positioned(
      right: 0,
      top: 40,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
            child: FutureBuilder(
              future: controller?.getFlashStatus(),
              builder: (context, snapshot) {
                return snapshot.data == true
                    ? Icon(Ionicons.flash_outline, size: 16.sp)
                    : Icon(Ionicons.flash_off_outline, size: 16.sp);
              },
            )),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: AppColors.amaranth,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 8,
        cutOutSize: 200.w,
        overlayColor: const Color.fromRGBO(0, 0, 0, 90),
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (isSanScan) {
        isSanScan = false; // Chặn quét mới cho đến khi hoàn thành xử lý
        if (checkQRData(scanData.code.toString())) {
          controller.pauseCamera();
          Get.back(result: scanData.code.toString());

          // Chờ 1 giây trước khi cho phép quét tiếp theo xảy ra
          Future.delayed(Duration(milliseconds: 1000), () {
            isSanScan = true;
          });
        } else {
          print('QR data is invalid!');
          // Sau khi xử lý xong, cho phép quét tiếp theo xảy ra ngay lập tức
          isSanScan = true;
        }
      }
    });
  }

  bool checkQRData(String data) {
    // Phân tách dữ liệu theo dấu "|"
    List<String> parts = data.split('|');

    // Kiểm tra xem có đủ số phần tử và định dạng của từng phần tử
    if (parts.length == 7) {
      // Kiểm tra định dạng của từng phần tử
      // Ví dụ: kiểm tra định dạng cho mã số, ngày sinh, giới tính, v.v.
      // Ở đây tôi sẽ giả định rằng tất cả các phần tử đều là chuỗi và không rỗng
      for (String part in parts) {
        if (part.isEmpty) {
          return false; // Nếu một trong các phần tử rỗng, trả về false
        }
      }
      // Nếu tất cả các điều kiện đều được đáp ứng, trả về true
      return true;
    } else {
      return false; // Nếu không đủ số phần tử, trả về false
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không được cấp quyền camera')),
      );
    }
  }
}
