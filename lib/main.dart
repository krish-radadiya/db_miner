import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'modules/controller/themeController.dart';
import 'modules/screens/spleshscreen/views/SplashScreen.dart';

final GetXSwitchState getXSwitchState = Get.put(GetXSwitchState());

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      theme: getXSwitchState.isSwitcheded
          ? ThemeData.light(
              useMaterial3: true,
            )
          : ThemeData.dark(
              useMaterial3: true,
            ),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
      ],
    ),
  );
}
