import "dart:ui";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hamara_bima_expo_application/features/screens/login_screen.dart";

import "../features/screens/splash_screen.dart";
import "../utils/constants.dart";

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HamaraBima Expo Application 3.3",
      scrollBehavior: kIsWeb ? MyCustomScrollBehavior() : null,
      theme: buildThemeData(context),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }

  ThemeData buildThemeData(BuildContext context) {
    return ThemeData(
      scrollbarTheme: const ScrollbarThemeData(thumbVisibility: WidgetStatePropertyAll(true)),
      canvasColor: bgColor,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: bgColor,

      // actionIconTheme: ActionIconThemeData(
      //   backButtonIconBuilder: (context) => Image.asset("assets/images/arrow-left.png"),
      // ),
      dropdownMenuTheme: const DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(fillColor: Color(0xFFF9f9f9)),
        menuStyle: MenuStyle(backgroundColor: WidgetStatePropertyAll(whiteColor), surfaceTintColor: WidgetStatePropertyAll(whiteColor), padding: WidgetStatePropertyAll(EdgeInsets.all(0)), fixedSize: WidgetStatePropertyAll(Size(200, 0))),
      ),
      colorScheme: ColorScheme.fromSeed(onSurfaceVariant: blackColor, surfaceTint: bgColor, seedColor: primaryColor, primary: primaryColor, onSurface: blackColor, secondary: secondaryColor, onPrimary: blackColor, onSecondary: whiteColor, shadow: blackColor),
      fontFamily: fontFamilyName,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        scrolledUnderElevation: 5,
        iconTheme: IconThemeData(color: whiteColor),
        titleTextStyle: TextStyle(color: whiteColor, fontSize: 20, fontFamily: fontFamilyName, fontWeight: FontWeight.w500),
      ),
      sliderTheme: const SliderThemeData(
        trackHeight: 1,

        thumbColor: whiteColor,
        // 007185
        overlayColor: whiteColor,
        activeTrackColor: greenColor,
        activeTickMarkColor: whiteColor,
        showValueIndicator: ShowValueIndicator.always,
        rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 7, pressedElevation: 0.00001, elevation: 0.00001),
      ),
      checkboxTheme: const CheckboxThemeData(splashRadius: 0, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, checkColor: WidgetStatePropertyAll(whiteColor)),
      popupMenuTheme: PopupMenuThemeData(color: whiteColor, position: PopupMenuPosition.under, surfaceTintColor: whiteColor, textStyle: Theme.of(context).textTheme.titleMedium),
      elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonTheme),
      inputDecorationTheme: inputDecorationThemeMain,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {PointerDeviceKind.trackpad, PointerDeviceKind.touch, PointerDeviceKind.mouse, PointerDeviceKind.stylus, PointerDeviceKind.unknown};
}
