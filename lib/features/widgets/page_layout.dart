import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hamara_bima_expo_application/utils/dialogs/dialogs.dart";

import "../../utils/constants.dart";

class PageLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final int selectedIndex;
  // final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool canLeavePage;
  final bool extendBody;
  final bool showBottomNavigationBar;
  final bool showDialogOnLeave;
  final String from;
  final String dialogTitleOnLeave;
  final String dialogMessageOnLeave;
  final String confirmText;
  final Future<void> Function()? onRefresh;
  final void Function()? onPop;
  final Color? backgroundColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const PageLayout({
    super.key,
    this.appBar,
    required this.body,
    // this.bottomNavigationBar,
    this.floatingActionButton,
    this.canLeavePage = true,
    this.showDialogOnLeave = false,
    this.onRefresh,
    this.extendBody = false,
    this.showBottomNavigationBar = false,
    required this.from,
    this.onPop,
    this.backgroundColor,
    this.dialogTitleOnLeave = "Wait! Are You Sure You Want to Leave?",
    this.dialogMessageOnLeave = "Before you go, please note that any unsaved changes will be permanently lost. Save them to avoid losing important information.",
    this.confirmText = "Leave",
    this.scaffoldKey,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: PopScope(
        canPop: onPop == null && canLeavePage && !showDialogOnLeave, // true || true && false | true || true
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          if (showDialogOnLeave) {
            final navigator = Navigator.of(context);
            bool value = await Dialogs.showConfirmationDialog(context, title: dialogTitleOnLeave, message: dialogMessageOnLeave, confirmText: confirmText, isDestructive: true);

            if (value) {
              if (onPop != null) {
                onPop!();
              } else {
                if (confirmText == "Yes, Exit") {
                  SystemNavigator.pop();
                } else {
                  navigator.pop(result);
                }
              }
            }
            return;
          }
          onPop?.call();
        },
        child: getBody(context),
      ),
      floatingActionButton: floatingActionButton,
      extendBody: extendBody,
      // drawer: showDrawer
      //     ? CusDrawer(
      //         from: from,
      //       )
      //     : null,
    );
  }

  Widget getBody(BuildContext context) {
    var widget = body;

    if (onRefresh != null) {
      widget = RefreshIndicator(onRefresh: onRefresh!, child: widget);
    }

    return widget;
  }
}
