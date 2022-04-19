import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pokebag_flutter/app/constants/string_utils.dart';

import '../controllers/pokebag_controller.dart';

class PokebagView extends GetView<PokebagController> {
  final pokeC = Get.find<PokebagController>();

  PokebagView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double szbWidth = (MediaQuery.of(context).size.width / 2).w;
    double szbHeight = (MediaQuery.of(context).size.width / 3).h;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokebag'),
        ),
        body: Obx(() => pokeC.isLoading.isTrue
            ? loadingBuild()
            : pokeC.isFailed.isTrue
                ? failedOrErrorBuild(pokeC.message.value)
                : pokeC.isSuccess.isTrue
                    ? (pokeC.pokebags.isNotEmpty
                        ? successBuild(szbWidth, szbHeight)
                        : failedOrErrorBuild(pokeC.message.value))
                    : failedOrErrorBuild(pokeC.message.value)));
  }

  Widget loadingBuild() =>
      const Center(child: CircularProgressIndicator.adaptive());

  Widget failedOrErrorBuild(String message) => Center(child: Text(message));

  Widget successBuild(double szbWidth, double szbHeight) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, bottom: 10.h),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              for (var item in pokeC.pokebags)
                SizedBox(
                  width: szbWidth,
                  height: 126.h,
                  child: Card(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.nameGiven.inCaps,
                                textAlign: TextAlign.justify,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15.5.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                item.dataPokemon.name!.inCaps,
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15.5.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 40.h),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: GestureDetector(
                                  onTap: () => pokeC.delete(item.id),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: item.dataPokemon.sprites.avatar
                                          .officialArtwork.picture !=
                                      null
                                  ? Image.network(
                                      item.dataPokemon.sprites.avatar
                                          .officialArtwork.picture!,
                                      cacheWidth: 140,
                                      cacheHeight: 140,
                                      scale: 2,
                                      fit: BoxFit.fitWidth,
                                    )
                                  : SvgPicture.asset(
                                      "assets/images/pokeball.svg",
                                      width: 60.w,
                                      height: 60.h,
                                      fit: BoxFit.cover,
                                    )),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
