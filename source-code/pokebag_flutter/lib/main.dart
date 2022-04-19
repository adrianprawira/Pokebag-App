import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/constants/main_config.dart';
import 'app/routes/app_pages.dart';

void main() {
  hideLogNPrint();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 672),
      builder: () => GetMaterialApp(
        title: "Pokebag Flutter App",
        initialRoute: AppPages.INITIAL,
        themeMode: ThemeMode.light,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: isDebugMode,
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQueryData.fromWindow(WidgetsBinding.instance!.window),
            child: widget!,
          );
        },
      ),
    ),
  );
}
