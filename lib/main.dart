import "dart:io";

import "package:flutter/material.dart";
import "package:hamara_bima_expo_application/core/app.dart";

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MainApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
