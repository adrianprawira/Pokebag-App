import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pokebag_flutter/app/data/models/entity/pokebag.dart';
import 'package:pokebag_flutter/app/data/models/response/pokemon/detail/poke-detail_response.dart';
import 'package:pokebag_flutter/app/services/remote_services.dart';
import 'package:pokebag_flutter/app/constants/string_utils.dart';

class PokebagController extends GetxController {
  var isLoading = false.obs;
  var isFailed = false.obs;
  var isSuccess = false.obs;
  var pokebags = <Pokebag>[].obs;
  RxString message = "Pokebags is Empty.".obs;
  RxString errMessage = "".obs;

  void fetchData() async {
    isLoading.value = true;
    try {
      final data = await RemoteServices.getPokebag();
      final notNull = jsonEncode(data) != "null";
      if (notNull) {
        final newData = data as Map<String, dynamic>;
        newData.forEach((id, data) {
          pokebags.add(Pokebag(id, data["pokeName"],
              PokemonDetailResponse.fromJson(data["dataPokemon"])));
        });
        // for (var i = 0; i < pokebags.length; i++) {
        //   debugPrint(pokebags[i].id);
        // }
        isLoading.value = false;
        isSuccess.value = true;
      } else {
        isLoading.value = false;
        isFailed.value = true;
      }
    } on DioError catch (e) {
      isLoading.value = false;
      errMessage.value = e.message;
      Get.showSnackbar(
        GetSnackBar(
          title: "error fetch data".capitalizeFirst,
          message: errMessage.value,
          backgroundColor: Colors.red.withOpacity(.9),
          snackPosition: SnackPosition.TOP,
          borderRadius: 10.r,
          maxWidth: 320.w,
          duration: const Duration(milliseconds: 2700),
        ),
      );
    }
  }

  void delete(String id) => Get.defaultDialog(
      title: "delete pokebag".capitalizeFirstofEach,
      middleText: "are you sure?".capitalizeFirstofEach,
      onCancel: () => RemoteServices.deletePokebag(id).then((_) {
            final index = pokebags.indexWhere((element) => element.id == id);
            pokebags.removeAt(index);
          }),
      textCancel: 'yes'.allInCaps,
      onConfirm: Get.back,
      textConfirm: 'no'.allInCaps,
      buttonColor: Colors.transparent,
      cancelTextColor: Get.isDarkMode ? Colors.teal : Colors.blue,
      confirmTextColor: Get.isDarkMode ? Colors.teal : Colors.blue,
      barrierDismissible: false);

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
}
