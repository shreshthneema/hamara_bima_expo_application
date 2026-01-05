import "package:flutter/material.dart";

enum AlertType { success, error, info }

class AlertModel {
  String? message;
  AlertType? alertType;
  AlertModel({this.message, this.alertType});
}

class AlertSnackBar extends StatelessWidget {
  final String? message;
  final AlertType? alertType;
  final int duration;

  const AlertSnackBar({
    super.key,
    this.message,
    this.alertType,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(10, 12, 10, 16),
          decoration: BoxDecoration(
            color: alertType == AlertType.success
                ? const Color(0xFF6DA544)
                : alertType == AlertType.error
                    ? const Color(0xFFD81A1A)
                    : const Color(0xFF13B7FF),
          ),
          child: Row(
            children: [
              Icon(
                alertType == AlertType.success
                    ? Icons.check_circle_rounded
                    : alertType == AlertType.info
                        ? Icons.info
                        : Icons.warning_rounded,
                color: const Color(0xFFFFFFFF),
                size: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                      text: alertType == AlertType.success
                          ? "Success "
                          : alertType == AlertType.info
                              ? "Info. "
                              : "Error! ",
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: message ?? " ",
                          style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],),
                ),
              ),
              // Text(
              //   alertType == AlertType.success
              //       ? 'Success '
              //       : alertType == AlertType.info
              //           ? 'Info. '
              //           : 'Error! ',
              //   style:
              // ),
              // // Spacer(),
              // Expanded(
              //   child: Text(
              //     message ?? " ",
              //     overflow: TextOverflow.ellipsis,
              //     maxLines: 1,
              //     style: const TextStyle(
              //       color: Color(0xFFFFFFFF),
              //       fontFamily: fontFamilyName,
              //       fontWeight: FontWeight.w400,
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            child: TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: duration),
              tween: Tween<double>(
                begin: 0,
                end: 1,
              ),
              builder: (context, value, _) => LinearProgressIndicator(
                backgroundColor: alertType == AlertType.success
                    ? const Color(0xFF6DA64E)
                    : alertType == AlertType.error
                        ? const Color(0xFFD81A1A)
                        : const Color(0xFF13B7FF),
                color: alertType == AlertType.success
                    ? const Color(0xFF527D33)
                    : alertType == AlertType.info
                        ? const Color(0xFF4BB1CF)
                        : const Color(0xFFA11313),
                value: value,
                // valueColor: AlwaysStoppedAnimation(
                //   alertType == AlertType.success
                //       ? const Color(0xFF008649)
                //       : alertType == AlertType.info
                //           ? const Color(0xFF4BB1CF)
                //           : const Color(0xFFED4F32),
                // ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: AlertSnackBar(
//                                   message:
//                                       'Something went wrong, try to refresh page or come back later.',
//                                   type: AlertType.success,
//                                 ),
//                                 behavior: SnackBarBehavior.floating,
//                                 backgroundColor: Colors.transparent,
//                                 elevation: 0,
//                                 width: 360,
//                               ),
//                             );
