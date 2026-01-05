import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:hamara_bima_expo_application/core/network/network.dart";
import "package:hamara_bima_expo_application/features/models/StallRegsitryResMainModel.dart";
import "package:hamara_bima_expo_application/features/models/UserResMainModel.dart";
import "package:hamara_bima_expo_application/features/screens/gate_entry_screen.dart";
import "package:hamara_bima_expo_application/features/screens/stall_entry_screen.dart";
import "package:hamara_bima_expo_application/features/widgets/common.dart";
import "package:hamara_bima_expo_application/utils/extensions/build_context_ext.dart";
import "package:new_version_plus/new_version_plus.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../core/network/shared_preference.dart";
import "../../utils/app_assets.dart";
import "../../utils/constants.dart";
import "../../utils/static_variable.dart";
import "../widgets/page_layout.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    // _loadSavedData();
    redirectToLogin();
    super.initState();
  }

  void redirectToLogin() async {
    ApiService();
    SharedPreference.localStorage = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      appBar: null,
      showBottomNavigationBar: false,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Spacer(),
            Hero(tag: "companyLogo", child: Image.asset(AppAssets.companyLogo, width: 250)),
            const Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 300,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  CommonTextField(
                    disabled: _isLoading,
                    controller: _userIdController,
                    // showRequired: true,
                    hintText: "Enter Your Mobile No",

                    text: "Mobile No",
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_userIdController.text.isEmpty) {
                          context.showSnackBarMessage("Please enter Mobile No");
                          return;
                        }
                        loginUser();
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      from: "",
    );
  }

  Future<void> loginUser() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final res = await ApiService.instance.getDocumentData(endpoint: APIEndPoint.stallRegsitryModel, queryParams: {"mobileNo": _userIdController.text}, converter: StallRegsitryResMainModel.fromJson, requiresAuthToken: false);

      if (res.value != null && res.value!.isNotEmpty) {
        // _saveData();

        final user = res.value![0];
        StaticVariable.loginUserDetail = user;

        context.push(StallEntryScreen());
      } else {
        context.showSnackBarMessage("Invalid Mobile No");
      }
    } on DioCustomException catch (e) {
      context.showSnackBarMessage(e.message);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // void _loadSavedData() async {
  //   var prefs = SharedPreference.localStorage!;
  //   setState(() {
  //     _rememberMe = prefs.getBool("rememberMe") ?? false;
  //     if (_rememberMe) {
  //       _userIdController.text = prefs.getString("username") ?? "";
  //       _passwordController.text = prefs.getString("password") ?? "";
  //     }
  //   });
  // }
  //
  // void _saveData() {
  //   var prefs = SharedPreference.localStorage!;
  //   prefs.setBool("rememberMe", _rememberMe);
  //   if (_rememberMe) {
  //     prefs.setString("username", _userIdController.text);
  //     prefs.setString("password", _passwordController.text);
  //   }
  // }
}
