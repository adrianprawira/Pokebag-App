import 'package:get/get.dart';

import '../controllers/pokebag_controller.dart';

class PokebagBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PokebagController>(
      () => PokebagController(),
    );
  }
}
