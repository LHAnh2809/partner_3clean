import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partner_3clean/app/common/util/exports.dart';
import 'package:partner_3clean/app/common/util/navigator.dart';
import 'package:partner_3clean/app/data/repository/api_helper.dart';
import 'package:partner_3clean/app/modules/create_account/view/widgets/check_dk_pw_widget.dart';
import 'package:partner_3clean/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:path/path.dart';

import '../../../data/models/sevice_models/sevice.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_svg.dart';
import '../../widgets/text_form_widget.dart';

class CreateAccountController extends GetxController
    with SingleGetTickerProviderMixin {
  final ApiHelper _apiHelper = Get.find();
  final TextEditingController textEmailController = TextEditingController();
  final TextEditingController textphoneNumberController =
      TextEditingController();
  final TextEditingController textPasswordController = TextEditingController();
  final TextEditingController textReEnterPasswordController =
      TextEditingController();
  final TextEditingController textCCCDController = TextEditingController();
  final TextEditingController textNameController = TextEditingController();
  final TextEditingController textNgaySinhController = TextEditingController();
  final TextEditingController textGioiTinhController = TextEditingController();
  final TextEditingController textDiaChiController = TextEditingController();
  final TextEditingController textNgayTaoTheController =
      TextEditingController();
  var selectedIndex = 0.obs;
  late TabController tabController;
  void selectTab(int index) {
    selectedIndex.value = index;
  }
  // Rx<File?> imageFile = Rx<File?>(null);
  // final picker = ImagePicker();

  var isEmailValid = false.obs;
  var isEmailNull = true.obs;
  var isSdtValid = false.obs;
  var isSdtNull = true.obs;
  var isPasswordVisible = true.obs;

  var isCharacters = false.obs;
  var isCapitalLetter = false.obs;
  var isOneDigit = false.obs;
  var isCheckGd = true.obs;

  var isEmailExists = false.obs;
  var isOtpIsWrong = false.obs;
  var isOtpWrong = false.obs;
  var isReferralCode = false.obs;
  var isReferralCodeNull = false.obs;

  var textQrCode = "".obs;
  var imageUrl = "".obs;
  var textLat = "".obs;
  var textLng = "".obs;

  var isLoading = false.obs;

  final List<String> options = ['Khác', 'Nam', 'Nữ'];
  final RxString selectedOption = RxString('Khác');
  var dateTime = DateTime.now().obs;
  var countdownValue = 60.obs;
  late Timer _timer;
  final RxString dateBirth = "".obs;
  final Rx<File?> image = Rx<File?>(null);
  final Rx<File?> imageCCCD = Rx<File?>(null);

  RxList<Service> listSevice = <Service>[].obs;

  String convertBoolListToIntList(List<bool> boolList) {
    List<int> intList = [];

    // Duyệt qua từng phần tử trong danh sách boolList
    for (bool value in boolList) {
      // Nếu giá trị là false, thêm 0 vào danh sách intList, ngược lại thêm 1
      if (value == false) {
        intList.add(0);
      } else {
        intList.add(1);
      }
    }

    // Chuyển đổi danh sách số nguyên thành chuỗi và loại bỏ các dấu ngoặc vuông
    String result = intList.join(
        ', '); // Sử dụng dấu phẩy và khoảng trắng để ngăn cách các giá trị

    return result;
  }


  Future<void> posttPartner() async {
    isLoading.value = true;
    try {
      var sex = 1;
      if (textGioiTinhController == "Nam") {
        sex = 0;
      }
      String convertedValues = convertBoolListToIntList(isSelectedList);
      final response = await _apiHelper.postPartner(
        email: textEmailController.text,
        phonenumber: textphoneNumberController.text,
        name: textNameController.text,
        service: convertedValues,
        password: textPasswordController.text,
        image: imageUrl.toString(),
        cccd: textCCCDController.text,
        datebirth: textNgaySinhController.text,
        dateCccd: textNgayTaoTheController.text,
        address: textDiaChiController.text,
        sex: sex,
      );
      if (response['detail'] == 0) {
        isLoading.value = false;
        goPresent(
          isDismissibles: false,
          children: [
            Text(
              'Cảm ơn bạn đã đăng ký',
              style:
                  AppTextStyle.textButtonStyle.copyWith(color: AppColors.black),
            ),
            SizedBox(width: 0.0, height: 16.h),
            CustomSvg(
              image: AppImages.iconCircleCheck,
              color: AppColors.caribbeanGreen,
              width: 48.w,
              height: 48.h,
            ),
            SizedBox(width: 0.0, height: 8.h),
            Text(
              'Nhân viên của 3Clean sẽ liên lạc với bạn trong vòng 24 giờ để tiến hành các thủ tục hợp đồng.\n\nNếu bạn cần thêm thông tin, vui lòng gọi hỗ trợ.',
              style: AppTextStyle.textsmallStyle,
            ),
            SizedBox(width: 0.0, height: 16.h),
            ButtonWidget(
              boder: true.obs,
              colorBackGroud: AppColors.white,
              onTap: () {
                Get.toNamed(Routes.login);
              },
              textStyle: AppTextStyle.textButtonStyle.copyWith(
                color: AppColors.black,
              ),
              text: "Trở về trang chủ",
            ),
          ],
        );
      }
    } catch (e) {
      debugPrint('Error in getAutoComplete: $e');
    }
  }

  Future<void> gettSevice() async {
    try {
      final response = await _apiHelper.getSevice();
      if (response['status'] == "OK") {
        List<Service> sevices = [];

        for (var userData in response['service']) {
          Service service = Service.fromJson(userData);
          sevices.add(service);
        }
        listSevice.value = sevices;
        initializeIsSelectedList(listSevice.length);
      }
    } catch (e) {
      debugPrint('Error in getAutoComplete: $e');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      final imageFile = await showImagePermanently(pickedImage.path);
      image.value = imageFile;
    } on PlatformException catch (e) {
      debugPrint("Không thể chụp ảnh: $e");
    }
  }

  Future<void> pickImageCCCD(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      final imageFile = await showImagePermanentlyCCCD(pickedImage.path);
      imageCCCD.value = imageFile;
    } on PlatformException catch (e) {
      debugPrint("Không thể chụp ảnh: $e");
    }
  }

  Future<File> showImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final imageFile = File('${directory.path}/$name');
    return File(imagePath).copy(imageFile.path);
  }

  Future<File> showImagePermanentlyCCCD(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final imageFile = File('${directory.path}/$name');
    return File(imagePath).copy(imageFile.path);
  }

  void formatData(String data) {
    // Tách dữ liệu thành các thành phần
    List<String> parts = data.split('|');

    // Lấy ngày tháng từ dữ liệu
    String birthday = parts[3];
    String issueDate = parts[6];

    // Thêm ký tự "/" vào ngày tháng
    // ignore: prefer_interpolation_to_compose_strings
    String formattedBirthday = birthday.substring(0, 2) +
        '/' +
        birthday.substring(2, 4) +
        '/' +
        birthday.substring(4);
    // ignore: prefer_interpolation_to_compose_strings
    String formattedIssueDate = issueDate.substring(0, 2) +
        '/' +
        issueDate.substring(2, 4) +
        '/' +
        issueDate.substring(4);
    textCCCDController.text = parts[0];
    textNameController.text = parts[2];
    textNgaySinhController.text = formattedBirthday;
    textGioiTinhController.text = parts[4];
    textDiaChiController.text = parts[5];
    textNgayTaoTheController.text = formattedIssueDate;
  }

  var isSelectedList = <bool>[].obs;

  Future<void> showImageCCCD(BuildContext context) async {
    final ImageSource? source = await (Platform.isIOS
        ? showCupertinoModalPopup<ImageSource>(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                  child: Text(
                    'Camera',
                    style: AppTextStyle.textbodyStyle,
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                  child: Text(
                    'Gallery',
                    style: AppTextStyle.textbodyStyle,
                  ),
                ),
              ],
            ),
          )
        : showModalBottomSheet<ImageSource>(
            context: context,
            builder: (BuildContext context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Camera'),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                ListTile(
                  title: const Text('Gallery'),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          ));

    if (source != null) {
      await pickImageCCCD(source);
    }
  }

  Future<void> showImageSource(BuildContext context) async {
    final ImageSource? source = await (Platform.isIOS
        ? showCupertinoModalPopup<ImageSource>(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                  child: Text(
                    'Camera',
                    style: AppTextStyle.textbodyStyle,
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                  child: Text(
                    'Gallery',
                    style: AppTextStyle.textbodyStyle,
                  ),
                ),
              ],
            ),
          )
        : showModalBottomSheet<ImageSource>(
            context: context,
            builder: (BuildContext context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Camera'),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                ListTile(
                  title: const Text('Gallery'),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          ));

    if (source != null) {
      await pickImage(source);
    }
  }

  void initializeIsSelectedList(int length) {
    isSelectedList.assignAll(List<bool>.filled(length, false));
  }

  void selectSvOption(int index) {
    if (isSelectedList.isEmpty || isSelectedList.length <= index) {
      // Mở rộng isSelectedList để chứa index
      isSelectedList
          .addAll(List<bool>.filled(index + 1 - isSelectedList.length, false));
    }
    // Gán giá trị tại index
    isSelectedList[index] = !isSelectedList[index];
    update();
  }

  @override
  void onInit() {
    String formattedDate = dateTime.value.formatDMY;
    tabController = TabController(length: 3, vsync: this);
    dateBirth.value = formattedDate;
    gettSevice();

    super.onInit();
  }

  void onTabIndexChanged(int index) {
    tabController.animateTo(index);
  }

  selectDate() {
    goDatePicker(
      onDateChanged: (DateTime? selectedDate) {
        // Xử lý ngày được chọn ở đây
        if (selectedDate != null) {
          String formattedDate = selectedDate.formatDMY;
          dateBirth.value = formattedDate;
        } else {
          debugPrint('No date selected');
        }
      },
    );
  }

  @override
  void dispose() {
    // imageFile.close();
    super.dispose();
  }

  @override
  void onClose() {
    textEmailController.dispose();
    textphoneNumberController.dispose();
    textPasswordController.dispose();
    textReEnterPasswordController.dispose();
    super.onClose();
  }

  bool checkTextControllersNotEmpty() {
    bool isAnyEmpty = false;
    isAnyEmpty =
        isAnyEmpty || checkControllerNotEmpty(textEmailController, 'Email');
    isAnyEmpty = isAnyEmpty ||
        checkControllerNotEmpty(textphoneNumberController, 'Phone number');
    isAnyEmpty = isAnyEmpty ||
        checkControllerNotEmpty(textPasswordController, 'Password');
    isAnyEmpty = isAnyEmpty ||
        checkControllerNotEmpty(
            textReEnterPasswordController, 'Re-enter Password');

    // Thêm điều kiện kiểm tra các biến khác
    isAnyEmpty = isAnyEmpty || !isEmailValid.value;
    isAnyEmpty = isAnyEmpty || isEmailNull.value;
    // Thêm các điều kiện khác tương tự ở đây

    return isAnyEmpty;
  }

  bool checkTextPasswordNotEmpty() {
    bool isAnyEmpty = false;
    // Kiểm tra xem mật khẩu có đủ độ dài
    isAnyEmpty = isAnyEmpty ||
        textPasswordController.value.text.length < 8 ||
        textReEnterPasswordController.value.text.length < 8;

    // Kiểm tra xem mật khẩu có chứa ít nhất một chữ in hoa
    isAnyEmpty = isAnyEmpty || !isCapitalLetter.value;

    // Kiểm tra xem mật khẩu có chứa ít nhất một chữ số
    isAnyEmpty = isAnyEmpty || !isOneDigit.value;

    // Kiểm tra xem hai mật khẩu có khớp nhau
    if (textPasswordController.value.text !=
        textReEnterPasswordController.value.text) {
      isAnyEmpty = true;
    }

    return isAnyEmpty;
  }

  bool checkControllerNotEmpty(
      TextEditingController controller, String fieldName) {
    bool isEmpty = controller.text.isEmpty;
    if (!isEmpty) {
      debugPrint('$fieldName is empty');
    } else {
      debugPrint('$fieldName  is not empty');
      ('$fieldName is not empty');
    }
    return isEmpty;
  }

  void setTextControllerDefaultIfEmpty(
      TextEditingController controller, String defaultValue) {
    if (controller.text.isEmpty) {
      controller.text = defaultValue;
    }
  }

  void checkEmailFormat(String email) {
    if (email.isEmpty) {
      isEmailNull.value = true;
      isEmailValid.value = false;
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    isEmailValid.value = emailRegex.hasMatch(email);
    isEmailNull.value = false;
  }

  void checkPhoneNumberFormat(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      isSdtNull.value = true;
      isSdtValid.value = false;
      return;
    }

    final phoneNumberRegex = RegExp(r'^[0-9]{10}$');

    isSdtValid.value = phoneNumberRegex.hasMatch(phoneNumber);
    isSdtNull.value = false;
  }

  void checkPassWordFormat(String password) {
    isCharacters.value = password.length >= 8;

    isCapitalLetter.value = password.contains(RegExp(r'[A-Z]'));

    isOneDigit.value = password.contains(RegExp(r'[0-9]'));
  }

  void checkPasswordsMatch(String password1, String password2) {
    if (password2.isEmpty) {
      isCheckGd.value = true;
      return;
    }
    if (password1 != password2) {
      isCheckGd.value = false;
      return;
    }
    // So sánh hai chuỗi mật khẩu với nhau
    if (password1 == password2) {
      isCheckGd.value = true;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void referralCodeNull(String code) {
    if (code.isEmpty) {
      isReferralCodeNull.value = false;
      return;
    }
    isReferralCodeNull.value = true;
  }

  final defaultPinTheme = PinTheme(
    width: 45.w,
    height: 45.h,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.black),
    ),
  );

  void startCountdown() {
    if (countdownValue.value < 60 && countdownValue.value > 1) {
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownValue.value > 0) {
        countdownValue.value -= 1;
      } else {
        _timer.cancel();
      }
    });
  }

  void resetCountdown() {
    countdownValue.value = 60;
    startCountdown();
  }

  String formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String formatDate(String dateStr) {
    // Tách chuỗi ngày thành các thành phần: ngày, tháng, năm
    List<String> parts = dateStr.split('/');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    // Định dạng ngày và tháng thành chuỗi có hai chữ số
    String formattedDay = day.toString().padLeft(2, '0');
    String formattedMonth = month.toString().padLeft(2, '0');

    // Trả về chuỗi ngày được định dạng mới
    return '$formattedDay/$formattedMonth/$year';
  }

  getCheckreferralCode(String code) async {
    try {
      final response = await _apiHelper.referralCode(code: code);
      final detail = response['detail'];
      if (detail == -1) {
        isReferralCode.value = false;
        return;
      } else {
        isReferralCode.value = true;
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getrequestOtp(String email) async {
    try {
      final response = await _apiHelper.requestOtp(
          email: email, name: textphoneNumberController.text);

      final detail = response['detail'];
      if (detail == -1) {
        isEmailExists.value = true;
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool isOtpWrongValue = false;
  getverifyOtp(String email, String otp, context) async {
    try {
      final response = await _apiHelper.verifyOtp(email: email, otp: otp);
      final detail = response['detail'];
      if (detail == -1) {
        isOtpIsWrong.value = true;
        return;
      } else {
        Get.back();
        isOtpWrong.listen((value) {
          isOtpWrongValue = value;
        });

        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getforgotPassword(String email, String newPassword) async {
    try {
      await _apiHelper.forgotPassword(email: email, newPassword: newPassword);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void forgotPaswordView(email, otp, context) async {
    final response = await _apiHelper.verifyOtp(email: email, otp: otp);
    final detail = response['detail'];
    if (detail == -1) {
      isOtpIsWrong.value = true;
      return;
    }
    Get.bottomSheet(
      // isScrollControlled: true,
      Container(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20).r,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.plsNewPassword,
                style: AppTextStyle.semiBoldMediumStyle
                    .copyWith(color: Colors.black),
              ),
              SizedBox(width: 0.0, height: 20.h),
              TextFormWidget(
                controller: textPasswordController,
                hintText: Strings.newPassword,
                textInputType: TextInputType.visiblePassword,
                obscureText: isPasswordVisible,
                togglePasswordVisibility: () {
                  togglePasswordVisibility();
                },
                showButton: true,
                onChanged: (value) {
                  checkPassWordFormat(value);
                  checkPasswordsMatch(
                      value, textReEnterPasswordController.value.text);
                },
              ),
              SizedBox(width: 0.0, height: 7.h),
              Obx(() {
                return CheckDkPwWidget(
                  text: Strings.characters,
                  color: isCharacters.value
                      ? AppColors.kGreenChart
                      : AppColors
                          .kGreyChart, // Sử dụng màu đỏ nếu không đáp ứng điều kiện
                );
              }),
              SizedBox(width: 0.0, height: 5.h),
              Obx(() {
                return CheckDkPwWidget(
                  text: Strings.capitalLetter,
                  color: isCapitalLetter.value
                      ? AppColors.kGreenChart
                      : AppColors
                          .kGreyChart, // Sử dụng màu đỏ nếu không đáp ứng điều kiện
                );
              }),
              SizedBox(width: 0.0, height: 5.h),
              Obx(() {
                return CheckDkPwWidget(
                  text: Strings.oneDigit,
                  color: isOneDigit.value
                      ? AppColors.kGreenChart
                      : AppColors
                          .kGreyChart, // Sử dụng màu đỏ nếu không đáp ứng điều kiện
                );
              }),
              SizedBox(width: 0.0, height: 10.h),
              TextFormWidget(
                controller: textReEnterPasswordController,
                hintText: Strings.reEnterPassword,
                textInputType: TextInputType.text,
                obscureText: isPasswordVisible,
                togglePasswordVisibility: () {
                  togglePasswordVisibility();
                },
                showButton: true,
                onChanged: (value) {
                  checkPasswordsMatch(textPasswordController.value.text, value);
                },
              ),
              SizedBox(width: 0.0, height: 5.h),
              Obx(
                () {
                  if (isCheckGd.value == false) {
                    return Text(
                      Strings.notTheSame,
                      style: AppTextStyle.buttonTextStyle
                          .copyWith(color: Colors.red, fontSize: 12.sp),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              SizedBox(width: 0.0, height: 10.h),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (checkTextPasswordNotEmpty() == true) {
                  } else {
                    getforgotPassword(email, textPasswordController.value.text);
                    Get.snackbar(
                      'Thông báo',
                      'Bạn đã đăng ký thành công vui lòng đăng nhập',
                      snackPosition: SnackPosition.TOP,
                      duration: const Duration(seconds: 3),
                      backgroundColor: AppColors.kSelectedDay.withOpacity(0.7),
                      colorText: Colors.white,
                    );
                    Get.offNamed(Routes.login);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: AppColors.kButtonColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8).r,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kButtonColor.withOpacity(0.2),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Text(
                    Strings.confirm,
                    style: AppTextStyle.buttonTextStyle.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
