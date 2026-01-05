import "dart:async";

import "../constants.dart";
import "package:flutter/material.dart";

import "loading_screen_controller.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

class LoadingScreen {
  factory LoadingScreen.instance() => _shared;

  LoadingScreen._sharedInstance();

  static final LoadingScreen _shared = LoadingScreen._sharedInstance();

  LoadingScreenController? _controller;

  void show({required BuildContext context, String text = "LOADING...", Color color = greenColor, bool showLoadingIndicator = true, void Function()? callback, LoadingControllerState status = LoadingControllerState.loading}) {
    if (_controller?.update(text, status) ?? false) {
      return;
    } else {
      _controller = _showOverlay(context: context, text: text, color: color, callback: callback, status: status);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController _showOverlay({required BuildContext context, required String text, required Color color, void Function()? callback, required LoadingControllerState status}) {
    final textStream = StreamController<String>()..add(text);
    final loadingStatusStream = StreamController<LoadingControllerState>()..add(status);
    final state = Overlay.of(context);
    LoadingControllerState assignStatus = status;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: callback != null
              ? InkWell(
                  onTap: callback,
                )
              : Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 250,
                      // minHeight: 100,
                      // maxHeight: size.height * 0.8,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(physics: const AlwaysScrollableScrollPhysics(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StreamBuilder<LoadingControllerState>(
                              stream: loadingStatusStream.stream,
                              builder: (context, snapshot) {
                                switch (snapshot.data) {
                                  case null:
                                  case LoadingControllerState.loading:
                                    return SpinKitRing(
                                      lineWidth: 2,
                                      size: 32,
                                      color: color,
                                      // waveColor: color.withOpacity(0.5),
                                    );
                                  case LoadingControllerState.success:
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    );
                                  case LoadingControllerState.error:
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    );
                                }
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: StreamBuilder<String>(
                                stream: textStream.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        if (assignStatus != LoadingControllerState.loading) {
          Future.delayed(const Duration(seconds: 1), () {
            textStream.close();
            loadingStatusStream.close();
            overlay.remove();
          });
        } else {
          textStream.close();
          loadingStatusStream.close();
          overlay.remove();
        }

        return true;
      },
      update: (text, status) {
        loadingStatusStream.add(status);
        assignStatus = status;
        textStream.add(text);
        return true;
      },
    );
  }
}

enum LoadingControllerState { loading, success, error }
