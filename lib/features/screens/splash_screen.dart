import "dart:async";

import "package:flutter/material.dart";
import "package:hamara_bima_expo_application/core/network/api_service.dart";
import "package:hamara_bima_expo_application/core/network/shared_preference.dart";
import "package:hamara_bima_expo_application/features/screens/gate_entry_screen.dart";
import "package:hamara_bima_expo_application/features/screens/login_screen.dart";
import "package:hamara_bima_expo_application/features/widgets/page_layout.dart";
import "package:hamara_bima_expo_application/utils/extensions/build_context_ext.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../utils/app_assets.dart";
import "../../utils/constants.dart";
import "../../utils/static_variable.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    redirectToLogin();
    loadVersion();

    super.initState();
  }

  void redirectToLogin() async {
    ApiService();
    SharedPreference.localStorage = await SharedPreferences.getInstance();
  }

  String? versionCode;

  void loadVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo.version);
    versionCode = packageInfo.version;
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      appBar: null,
      showBottomNavigationBar: false,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Spacer(),
            Hero(tag: "companyLogo", child: Image.asset(AppAssets.companyLogo, width: 250)),
            const Spacer(),
            // Text("Choose From Below Options"),
            const SizedBox(height: 15),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  context.push(const GateEntryScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blackColor,
                ),
                child: Text(
                  "Gate Entry",
                  style: TextStyle(
                    color: whiteColor,
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 10),
            // SizedBox(
            //   width: 300,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       context.push(const LoginScreen());
            //     },
            //     child: Text(
            //       "Exibit Entry",
            //       style: TextStyle(
            //         color: whiteColor,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            Text(
              "Version ${versionCode ?? ""}",
              style: const TextStyle(color: greyDark, fontSize: 12, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      from: "",
    );
  }
}

class LoadingTextAnimation extends StatefulWidget {
  const LoadingTextAnimation({super.key});

  @override
  State<LoadingTextAnimation> createState() => _LoadingTextAnimationState();
}

class _LoadingTextAnimationState extends State<LoadingTextAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int _currentIndex = 0;
  final List<String> _loadingTexts = ["Syncing Data...", "Syncing Data...", "Please Wait...", "Almost Done...", "Finalizing..."];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _startAnimationLoop();
  }

  void _startAnimationLoop() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        _controller.reverse().then((_) {
          setState(() {
            _currentIndex = (_currentIndex + 1) % _loadingTexts.length;
          });
          _controller.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Text(
        _loadingTexts[_currentIndex],
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: lightGrayTwo),
      ),
    );
  }
}
