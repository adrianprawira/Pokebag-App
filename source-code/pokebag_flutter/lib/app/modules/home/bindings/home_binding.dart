import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/theme_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
  }
}
