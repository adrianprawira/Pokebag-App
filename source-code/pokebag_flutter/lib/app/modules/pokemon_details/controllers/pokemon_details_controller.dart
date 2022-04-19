import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pokebag_flutter/app/constants/random_number.dart';
import 'package:pokebag_flutter/app/constants/string_utils.dart';
import 'package:pokebag_flutter/app/data/models/response/pokemon/detail/poke-detail_response.dart';
import 'package:pokebag_flutter/app/routes/app_pages.dart';
import 'package:pokebag_flutter/app/services/remote_services.dart';

class PokemonDetailsController extends GetxController {
  var catchSuccess = false.obs;
  var catchFailed = false.obs;
  var title = "".obs;
  PokemonDetailResponse dataPokemon = Get.arguments;

  late TextEditingController namingPokemonController;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    namingPokemonController = TextEditingController();
  }

  @override
  void onClose() {
    namingPokemonController.dispose();
    super.onClose();
  }

  void saveData(
      {required String nameGiven, required PokemonDetailResponse dataPokemon}) {
    if (formKey.currentState!.validate()) {
      RemoteServices.postPokebag(
          nameGiven: nameGiven, dataPokemon: dataPokemon);
      namingPokemonController.clear();
      Get.back();
      return successDialog();
    }
  }

  void getDialog(String title, String message) {
    if (catchFailed.isTrue) {
      Get.defaultDialog(
          onConfirm: Get.back,
          textConfirm: 'ok'.allInCaps,
          buttonColor: Colors.transparent,
          confirmTextColor: Get.isDarkMode ? Colors.teal : Colors.blue,
          title: title,
          middleText: message,
          barrierDismissible: false);
    } else {
      Get.dialog(
          AlertDialog(
            title: Text(title, textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message, textAlign: TextAlign.center),
                SizedBox(height: 16.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            if (val.isBlank!) {
                              return 'value must be filled.'.capitalizeFirst;
                            }
                          },
                          controller: namingPokemonController,
                          decoration: InputDecoration(
                              label: Text('pokemon name'.capitalizeFirstofEach,
                                  style: TextStyle(fontSize: 13.sp)))),
                    )),
                SizedBox(height: 16.h),
                Center(
                    child: TextButton(
                        onPressed: () => saveData(
                            nameGiven: namingPokemonController.text,
                            dataPokemon: dataPokemon),
                        child: Text('submit'.allInCaps,
                            style: TextStyle(fontSize: 15.sp)),
                        style: TextButton.styleFrom(
                            primary:
                                Get.isDarkMode ? Colors.teal : Colors.blue))),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.r))),
          ),
          barrierDismissible: false);
    }
  }

  void successDialog() {
    Get.defaultDialog(
        title: 'success'.inCaps,
        middleText:
            'your pokemon has been saved to pokebag, wanna check it now?'
                .capitalizeFirstofEach,
        onConfirm: () => Get.offNamed(Routes.POKEBAG),
        textConfirm: 'ok'.allInCaps,
        confirmTextColor: Get.isDarkMode ? Colors.teal : Colors.blue,
        buttonColor: Colors.transparent,
        textCancel: 'no'.allInCaps,
        cancelTextColor: Get.isDarkMode ? Colors.teal : Colors.blue,
        barrierDismissible: false);
  }

  int mixIndex() {
    int length = 7;
    NRandom nrand = NRandom(length);

    final index = nrand.getNextIndex();

    return (index <= 0) ? length : index;
  }

  void probabilityCheck() {
    int length = mixIndex();

    NRandom nrand = NRandom(length);

    final result = nrand.getNextIndex();

    if (result == 3 || result == 1) {
      catchSuccess.value = true;
      catchFailed.value = false;
      title.value = ('congratulation').inCaps;
      getDialog(
          title.value,
          'you have earned a pokemon.\nIt will be saved in pokebag.\nPlease name it well.'
              .capitalizeFirstofEach);
    } else {
      catchFailed.value = true;
      catchSuccess.value = false;
      title.value = ('bad luck').inCaps;
      getDialog(title.value, ('try again next time!.').inCaps);
    }

    debugPrint(title.value);
  }
}
