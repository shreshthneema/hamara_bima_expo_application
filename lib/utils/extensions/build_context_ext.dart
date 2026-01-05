import "package:flutter/cupertino.dart";

import "../../features/widgets/snack_bar.dart";
import "package:flutter/material.dart";

import "../constants.dart";

extension Context on BuildContext {
  void closeKeyboard() => FocusScope.of(this).unfocus();

  void showSnackBarMessage(
    String message, {
    bool isError = true,
    bool isInfo = false,
    int duration = 4000,
  }) {
    if (mounted) {
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          duration: Duration(milliseconds: duration),
          showCloseIcon: false,
          // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          content: AlertSnackBar(
            duration: duration,
            message: message,
            alertType: isError
                ? AlertType.error
                : isInfo
                    ? AlertType.info
                    : AlertType.success,
          ),
          closeIconColor: whiteColor,
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError
              ? const Color(0xFFD81A1A)
              : !isInfo
                  ? const Color(0xFF6DA544)
                  : const Color(0xFF13B7FF),
          padding: EdgeInsets.zero,
          shape: const LinearBorder(),
          width: null,
        ),
      );
    }
  }

  // bool get isDesktop {
  //   final maxWidth = MediaQuery.sizeOf(this).width;
  //   return maxWidth > tabletScreenBreakpoint;
  // }

  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;

  Future<dynamic> push(Widget page) => Navigator.push(
        this,
        CupertinoPageRoute(
          builder: (context) => page,
          settings: RouteSettings(
            name: page.toString(),
          ),
        ),
      );
  Future<dynamic> pushM(Widget page) => Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) => page,
          settings: RouteSettings(
            name: page.toString(),
          ),
        ),
      );

  void pop({dynamic data}) => Navigator.pop(this, data);
  Future<dynamic> pushReplacement(Widget page, {bool fromDashboard = false}) => Navigator.pushReplacement(this, fromDashboard ? MaterialPageRoute(builder: (context) => page) : CupertinoPageRoute(builder: (context) => page));
  void replace(Widget oldPage, Widget page) => Navigator.replace(this, newRoute: CupertinoPageRoute(builder: (context) => page), oldRoute: CupertinoPageRoute(builder: (context) => oldPage));
  void popUntil<T extends Widget>() => Navigator.popUntil(this, (route) => route is CupertinoPageRoute && route.builder(this) is T);
  // void popUntil<T extends Widget>() {
  //   print(T.toString());
  //   return Navigator.popUntil(this, (route) => route.settings.name == T.toString());
  // }

  void pushAndRemoveUntil(Widget page) => Navigator.pushAndRemoveUntil(
        this,
        CupertinoPageRoute(builder: (context) => page), // Replace with your new page
        (Route<dynamic> route) => false, // Removes all routes
      );
}
