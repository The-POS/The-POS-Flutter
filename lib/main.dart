import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/routes/app_pages.dart';

import 'localization/localization_service.dart';

Future<void> main() async {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      getPages: routes,
      initialRoute: initial,
      locale: LocalizationService.locale,
      translations: LocalizationService(),
      builder: (context, widget) => ResponsiveWrapper.builder(
        widget,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(23, 143, 73, 1.0),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(244, 245, 250, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
