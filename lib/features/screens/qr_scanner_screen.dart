import "package:flutter/material.dart";
import "package:hamara_bima_expo_application/utils/extensions/build_context_ext.dart";
import "package:mobile_scanner/mobile_scanner.dart";

class QRScannerScreen extends StatefulWidget {
  final bool forEndRide;
  const QRScannerScreen({super.key, this.forEndRide = false});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> with SingleTickerProviderStateMixin {
  final MobileScannerController cameraController = MobileScannerController();
  bool _isScanCompleted = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation for moving scan line
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isScanCompleted) return;

    final barcode = capture.barcodes.first;
    final value = barcode.rawValue;

    if (value != null) {
      _isScanCompleted = true;
      debugPrint("Scanned: $value");

      context.pop(data: value);
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Scanner"),
        actions: [IconButton(icon: const Icon(Icons.flash_on), onPressed: () => cameraController.toggleTorch())],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            // allowDuplicates: false,
            onDetect: _onDetect,
          ),
          // Overlay
          _buildScannerOverlay(context),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double boxSize = size.width * 0.7;

    return Center(
      child: SizedBox(
        width: boxSize,
        height: boxSize,
        child: Stack(
          children: [
            // Border
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
            ),
            // Moving red line
            AnimatedBuilder(
              animation: _animation,
              builder: (_, child) {
                return Positioned(
                  top: _animation.value * boxSize,
                  left: 0,
                  right: 0,
                  child: Container(height: 2, color: Colors.redAccent),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
