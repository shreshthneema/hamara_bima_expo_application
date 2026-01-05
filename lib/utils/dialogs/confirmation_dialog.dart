import "dart:io";

import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import "../constants.dart";

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({required this.title, required this.message, required this.cancelText, required this.confirmText, required this.isDestructive, super.key, this.onCancel, this.onConfirm, required this.showSaveToDaftButton});

  final String title;
  final String? message;
  final String confirmText;
  final String? cancelText;
  final bool isDestructive;
  final bool showSaveToDaftButton;
  final void Function()? onCancel;
  final void Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return !kIsWeb && Platform.isIOS ? _IosConfirmationDialog(showSaveToDaftButton: showSaveToDaftButton, title: title, message: message, confirmText: confirmText, isDestructive: isDestructive, cancelText: cancelText, onConfirm: onConfirm, onCancel: onCancel) : _AndroidConfirmationDialog(showSaveToDaftButton: showSaveToDaftButton, title: title, message: message, confirmText: confirmText, isDestructive: isDestructive, cancelText: cancelText, onConfirm: onConfirm, onCancel: onCancel);
  }
}

class _AndroidConfirmationDialog extends StatelessWidget {
  const _AndroidConfirmationDialog({required this.title, required this.message, required this.confirmText, required this.isDestructive, this.onConfirm, required this.cancelText, this.onCancel, required this.showSaveToDaftButton});

  final String title;
  final String? message;
  final String confirmText;
  final bool isDestructive;
  final bool showSaveToDaftButton;
  final String? cancelText;
  final void Function()? onCancel;
  final void Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titlePadding: title.isEmpty ? EdgeInsets.zero : const EdgeInsets.fromLTRB(20, 20, 20, 5),
      contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      actionsPadding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
      insetPadding: const EdgeInsets.symmetric(horizontal: 50),
      // surfaceTintColor: Colors.white,
      elevation: 100,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 10),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF000000)),
        ),
      ),
      content: message != null ? buildMessage() : null,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        if (showSaveToDaftButton) buildSaveToDraftButton(context),
        Row(
          children: [
            if (cancelText != null)
              Expanded(
                child: Material(
                  color: lightGrayTwo,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: onCancel ?? () => Navigator.pop(context, false),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          cancelText!,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF4B4E4E)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (cancelText != null) const SizedBox(width: 10),
            Expanded(
              child: Material(
                color: isDestructive ? const Color(0xFFF1414F) : secondaryColor,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: onConfirm ?? () => Navigator.pop(context, true),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        confirmText,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSaveToDraftButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: lightGrayTwo,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onCancel ?? () => Navigator.pop(context, false),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Save To Draft",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF4B4E4E)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text buildMessage() {
    return Text(message!, style: const TextStyle(fontSize: 14, color: darkGreyTwo));
  }
}

class _IosConfirmationDialog extends StatelessWidget {
  const _IosConfirmationDialog({required this.title, required this.message, required this.confirmText, required this.isDestructive, required this.cancelText, this.onConfirm, this.onCancel, required this.showSaveToDaftButton});

  final String title;
  final String? message;
  final String confirmText;
  final bool isDestructive;
  final String? cancelText;
  final bool showSaveToDaftButton;

  final void Function()? onCancel;
  final void Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 10),
        child: Text(title, style: const TextStyle(fontFamily: fontFamilyName)),
      ),
      content: message != null ? Text(message!, style: const TextStyle(fontFamily: fontFamilyName)) : null,
      actions: [
        if (showSaveToDaftButton)
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onCancel ?? () => Navigator.pop(context, false),
            child: const Text(
              "Save As Draft",
              style: TextStyle(
                fontFamily: fontFamilyName,
                fontSize: 15,
                // fontWeight: FontWeight.w600,
                // color: const Color(0xFF4B4E4E),
              ),
            ),
          ),
        if (cancelText != null)
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onCancel ?? () => Navigator.pop(context, false),
            child: Text(
              cancelText!,
              style: const TextStyle(
                fontFamily: fontFamilyName,

                fontSize: 15,
                // fontWeight: FontWeight.w600,
                // color: const Color(0xFF4B4E4E),
              ),
            ),
          ),

        CupertinoDialogAction(
          isDestructiveAction: isDestructive,
          onPressed: onConfirm ?? () => Navigator.pop(context, true),
          child: Text(
            confirmText,
            style: const TextStyle(
              fontFamily: fontFamilyName,

              //   fontSize: 14,
              //   fontWeight: FontWeight.w600,
              //   color: isDestructive ? const Color(0xFFF1414F) : const Color(0xFF4B4E4E),
            ),
          ),
        ),

        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: isDestructive
        //         ? context.colorScheme.error
        //         : blueColor,
        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        //     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        //   ),
        //   onPressed: () => Navigator.pop(context, true),
        //   child: Text(confirmText, style: headerTextW,),
        // ),
      ],
    );
  }
}
