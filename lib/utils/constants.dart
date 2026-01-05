import "dart:developer" show log;
import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

void consoleLog(dynamic msg) {
  log(msg.toString());
  // if (kDebugMode) {
  // }
}

Widget showLoading() {
  return const Center(child: SpinKitRing(color: whiteColor, lineWidth: 4));
}

const fontFamilyName = "Inter";

const primaryColor = Color(0xFFe41c27);
// const primaryColor = Color(0xFF4D8863);
const secondaryColor = Color(0xFFFFFFFF);
const bgColor = Color(0xFFFAFAFA);

const whiteColor = Color(0xFFFFFFFF);
const highlightColor = Color(0xFFFFFFFF);
const lightGrayOne = Color(0xFFFAFAFA);
const lightGrayTwo = Color(0xFFE6E6E6);
const greyMed = Color(0xFFCDCDCD);
const greyDark = Color(0xFF9A9A9A);
const darkGreyOne = Color(0xFF6F7373);
const darkGreyTwo = Color(0xFF4B4E4E);

const blackColorLight = Color(0xFF0f1111);
const blackColor = Color(0xFF1F2024);

const redColor = Color(0xffED262E);
const yellow = Color(0xFFeb8c28);
const greenColor = Color(0xFF12912b);

const shimmerBaseColor = Color(0xFF3A4CC4); // muted blue-grey for base
const shimmerHighlightColor = Color(0xFF8FA9FF); // soft
const shimmerBaseColorLight = Color(0xFFE0E0E0);
const shimmerHighlightColorLight = Color(0xFFFFF6EE);
// light blue highlight
//const lightBlueColor = Color(0xFFeef7fe);
//const purpleGreen = Color(0xFF13d689);
//const lightBlue = Color(0xFF5d92aa);
//const darkBlue = blackColor;
//const madBlue = Color(0xFF0c4454);

// Theme constants
const double defaultPadding = 20.0;
const double borderRadius = 8.0;

enum OrderStatus { Open, Close }

class Constants {
  static Padding buildGeneralDetailViewIcon(String title, String data, IconData icon, {Widget? child, double verticalPadding = 8, bool isExpanded = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: whiteColor),
            child: Icon(icon, fill: 1, weight: 500, color: primaryColor, size: 28),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: darkGreyOne, fontWeight: FontWeight.w600),
                ),
                // const SizedBox(height: 2),
                child ??
                    Text(
                      data,
                      style: const TextStyle(fontSize: 15, color: blackColor, fontWeight: FontWeight.w700),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Padding buildGeneralDetailView(String title, String data, {Widget? child, double verticalPadding = 5, bool isExpanded = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, color: darkGreyOne, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 15),
          if (isExpanded)
            Expanded(
              child: child ??
                  Text(
                    data,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 16, color: blackColor, fontWeight: FontWeight.w700),
                  ),
            )
          else
            child ??
                Text(
                  data,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 16, color: blackColor, fontWeight: FontWeight.w700),
                ),
        ],
      ),
    );
  }

  static void showCustomBottomSheet(BuildContext context, String title, Widget mainWidget, {double heightFactor = 0.5, bool isExpanded = true}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: lightGrayOne,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: heightFactor, // 80% of screen height
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 30,
                height: 2,
                decoration: BoxDecoration(color: greyMed, borderRadius: BorderRadius.circular(15)),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18, color: darkGreyTwo, fontWeight: FontWeight.w700),
                ),
              ),
              if (isExpanded) Expanded(child: mainWidget) else mainWidget,
            ],
          ),
        );
      },
    );
  }
}

final elevatedButtonTheme = ElevatedButton.styleFrom(
  elevation: 2,
  backgroundColor: primaryColor,
  textStyle: const TextStyle(fontWeight: FontWeight.w500, fontFamily: fontFamilyName, color: whiteColor, fontSize: 14),
  // maximumSize: Size(100, 50),
  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  foregroundColor: primaryColor,
  disabledBackgroundColor: greyMed,
);
//
var inputDecorationThemeMain = const InputDecorationTheme(
  counterStyle: TextStyle(color: primaryColor),
  iconColor: primaryColor,
  labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: primaryColor, fontFamily: fontFamilyName),
  hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: blackColor, fontFamily: fontFamilyName),
  floatingLabelStyle: TextStyle(fontSize: 18, height: 1, fontWeight: FontWeight.w400, color: primaryColor, fontFamily: fontFamilyName),
  errorStyle: TextStyle(fontSize: 12, height: 1, color: redColor, fontWeight: FontWeight.w400, fontFamily: fontFamilyName),
  suffixIconColor: greyMed,
  border: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),

  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: blackColor),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  fillColor: highlightColor,
  filled: true,

  // floatingLabelBehavior: FloatingLabelBehavior.always,
  contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
);
