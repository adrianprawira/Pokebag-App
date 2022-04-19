import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pokebag_flutter/app/constants/string_utils.dart';
import 'package:pokebag_flutter/app/constants/widgets/animated_image.dart';
import 'package:pokebag_flutter/app/data/models/response/pokemon/detail/poke-detail_response.dart';

import '../controllers/pokemon_details_controller.dart';

class PokemonDetailsView extends GetView<PokemonDetailsController> {
  final probsC = Get.find<PokemonDetailsController>();

  PokemonDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width.w;
    PokemonDetailResponse dataPokemon = probsC.dataPokemon;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0.0,
        title: Text((dataPokemon.name!).inCaps),
        titleTextStyle:
            TextStyle(color: Colors.blueAccent.shade700, fontSize: 20.sp),
        iconTheme: IconThemeData(
          color: Colors.blueAccent.shade700,
        ),
      ),
      body: ListView(
        children: [
          Container(
            width: widthScreen,
            child: Padding(
              padding: EdgeInsets.only(top: 16.h, left: 16.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      children: [
                        for (var item in dataPokemon.types)
                          Chip(
                            label: Text(
                              item.type.name,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            backgroundColor: Colors.brown.shade700,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                          ),
                      ],
                      spacing: 16.w,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  FadeInImage(
                      placeholder: const AssetImage(
                        'assets/images/pokeball.png',
                      ),
                      image: NetworkImage(
                        dataPokemon.sprites.avatar.officialArtwork.picture,
                        scale: 2,
                      ),
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            'assets/images/pokeball.png',
                            scale: 2,
                          ))
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r))),
          ),
          Container(
            width: widthScreen,
            color: Colors.transparent,
            margin: EdgeInsets.only(top: 24.h, left: 8.w, right: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ('moves').inCaps,
                  style: TextStyle(
                      color: Colors.blueAccent.shade700, fontSize: 24.sp),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: [
                      for (var item in dataPokemon.moves)
                        Chip(
                          label: Text(
                            item.move.name,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          backgroundColor: Colors.blueGrey.shade700,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                        ),
                    ],
                    spacing: 8.w,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
          onTap: probsC.probabilityCheck,
          child: SizedBox(
            child: const AnimatedImage(images: "pokeball.svg"),
            height: 50.h,
            width: 50.w,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
