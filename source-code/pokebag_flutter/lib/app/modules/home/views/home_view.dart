import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokebag_flutter/app/modules/home/controllers/theme_controller.dart';

import 'widgets/search_view.dart';

import '../controllers/home_controller.dart';
import '../../../constants/string_utils.dart';
import '../../../routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  final homeC = Get.find<HomeController>();
  final themeC = Get.find<ThemeController>();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double szbWidth = (MediaQuery.of(context).size.width / 2).w;
    double szbHeight = (MediaQuery.of(context).size.width / 2.75).h;

    return Scaffold(
      appBar: AppBar(
        leading: GetBuilder<ThemeController>(
          builder: (controller) => IconButton(
              onPressed: controller.toggleDarkMode,
              icon: Icon(controller.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_outlined)),
        ),
        title: const Text('Pokedex'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.POKEBAG),
            icon: SvgPicture.asset(
              "assets/images/pokeball.svg",
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            SearchPokemon(
              text: homeC.query.value,
              onChanged: homeC.isSuccess.isTrue ? homeC.searchPokemon : null,
              readOnly: homeC.isSuccess.isTrue ? false : true,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: homeC.refresh,
                child: homeC.isLoading.isTrue
                    ? loadingBuild()
                    : homeC.isFailed.isTrue
                        ? failedBuild()
                        : homeC.isSuccess.isTrue
                            ? (homeC.listPoke.isNotEmpty
                                ? successBuild(szbWidth, szbHeight)
                                : failedBuild())
                            : const Center(
                                child: Text('There must be something wrong')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget successBuild(double szbWidth, double szbHeight) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, bottom: 10.h),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              for (var item in (homeC.listPoke.isNotEmpty
                  ? homeC.listPoke
                  : homeC.pokemonList))
                GestureDetector(
                  onTap: () =>
                      Get.toNamed(Routes.POKEMON_DETAILS, arguments: item),
                  child: SizedBox(
                    width: szbWidth,
                    height: 131.h,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (item.name!).inCaps,
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 16.h),
                            Align(
                                alignment: Alignment.centerRight,
                                child: item.sprites.avatar.officialArtwork
                                            .picture !=
                                        null
                                    ? Image.network(
                                        item.sprites.avatar.officialArtwork
                                            .picture!,
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
                                      ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        homeC.fetchMoreLoading.isTrue
            ? Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child:
                    const Center(child: CircularProgressIndicator.adaptive()),
              )
            : homeC.hasReachMax.isTrue
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 30.h, 10.w, 10.h),
                    child: TextButton(
                      onPressed: homeC.fetchMore,
                      child: Text(
                        'Show More',
                        style: TextStyle(fontSize: 14.sp, color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blueAccent),
                    ),
                  )
      ],
    );
  }

  Widget loadingBuild() {
    return const Center(child: CircularProgressIndicator.adaptive());
  }

  Widget failedBuild() {
    return const Center(child: Text('Data Not Found'));
  }
}
