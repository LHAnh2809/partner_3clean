import 'package:firebase_core/firebase_core.dart';
import 'package:partner_3clean/app/common/util/notification_sevice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:partner_3clean/app/data/repository/api_helper_impl.dart';
import 'app/common/util/exports.dart';
import 'app/common/util/initializer.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() {
  Initializer.instance.init(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await ApiHelperImpl().fetchDataFromFirestore();
    WidgetsFlutterBinding.ensureInitialized();
    await NotificationService.initializeNotification();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (context, widget) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        defaultTransition: Transition.fadeIn,
        initialRoute: Routes.splash,
        getPages: AppPages.routes,
        initialBinding: InitialBindings(),
      ),
    );
  }
}
