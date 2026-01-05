import "dart:io";

import "package:flutter/material.dart";

import "confirmation_dialog.dart";

sealed class Dialogs {
  const Dialogs._();

  // static Future<void> showDeleteAccountConfirmationDialog(
  //   BuildContext context,
  // ) async {
  //   final confirmed = await _showConfirmationDialog(
  //     context,
  //     title: 'Delete Account',
  //     message: 'Are you sure you want to delete your account forever? '
  //         'It can take up to 30 days. This cannot be undone.',
  //     confirmText: 'Delete My Account',
  //     isDestructive: true,
  //   );

  //   if (confirmed && context.mounted) {
  //     // TODO: implement delete account
  //     context.showSnackBarMessage('Request submitted.');
  //   }
  // }

  // static Future<void> showLogOutConfirmationDialog(
  //   BuildContext context,
  // ) async {
  //   final confirmed = await _showConfirmationDialog(
  //     context,
  //     title: 'Sign Out',
  //     message: 'Are you sure you want to sign out?',
  //     confirmText: 'Sign Out',
  //     isDestructive: true,
  //   );

  //   if (confirmed && context.mounted) {
  //     context.read<UserCubit>().logOut();
  //     AppRoute.home.go(context);
  //   }
  // }

  static Future<bool> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String confirmText,
    String? cancelText = "Cancel",
    String? message,
    bool isDestructive = false,
    bool showSaveToDaftButton = false,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: title,
            message: message,
            confirmText: confirmText,
            isDestructive: isDestructive,
            cancelText: cancelText,
            showSaveToDaftButton: showSaveToDaftButton,
          ),
        ) ??
        false;
  }

  static void showImagePopupNetwork(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: InteractiveViewer(
              // Allows pinch zoom
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  static void showImagePopup(BuildContext context, File image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: InteractiveViewer(
              // Allows pinch zoom
              child: Image.file(
                File(image.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
