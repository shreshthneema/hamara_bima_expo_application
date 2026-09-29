import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:hamara_bima_expo_application/core/network/network.dart";
import "package:hamara_bima_expo_application/features/models/StallVisitEntryResMainModel.dart";
import "package:hamara_bima_expo_application/features/screens/qr_scanner_screen.dart";
import "package:hamara_bima_expo_application/features/widgets/page_layout.dart";
import "package:hamara_bima_expo_application/utils/dialogs/loading_screen.dart";
import "package:hamara_bima_expo_application/utils/extensions/build_context_ext.dart";
import "package:hamara_bima_expo_application/utils/extensions/date_format.dart";
import "package:hamara_bima_expo_application/utils/static_variable.dart";

import "../../utils/constants.dart";

class StallEntryScreen extends StatefulWidget {
  const StallEntryScreen({super.key});

  @override
  State<StallEntryScreen> createState() => _StallEntryScreenState();
}

class _StallEntryScreenState extends State<StallEntryScreen> {
  @override
  void initState() {
    getStallVisits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: const SizedBox(),
        leadingWidth: 0,
        title: const Text("Visits"),
      ),
      body: _loading
          ? const Center(
              child: SpinKitFadingCircle(color: primaryColor),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (_satllVisitList.isEmpty) Image.asset("assets/images/data-not-found.jpg"),
                  for (var visit in _satllVisitList)
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: darkGreyOne,
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.person, color: primaryColor),
                        title: Text(visit.visitorName ?? ""),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Designation: ${visit.visitorDesignation ?? ""}"),
                            Text("Organization: ${visit.visitorOrganization ?? ""}"),
                            Text("Email: ${visit.visitorEmailId ?? ""}"),
                            Text("Mobile No ${visit.visitorMobileNo ?? ""}"),
                            // Text("Date: ${visit. ?? ''}"),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
      from: "Stall Entry",
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: primaryColor,
            elevation: 5,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              onTap: () async {
                final data = await context.push(const QRScannerScreen());
                if (data != null && data is String) {
                  addStallVisitEntry(data);
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.qr_code_scanner,
                  size: 35,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<StallVisitEntryResDataModel> _satllVisitList = [];

  bool _loading = false;
  Future<void> getStallVisits() async {
    try {
      setState(() {
        _loading = true;
      });
      final stall = StaticVariable.loginUserDetail;
      final res = await ApiService.instance.getDocumentData(
        endpoint: APIEndPoint.stallVisitEntry,
        converter: StallVisitEntryResMainModel.fromJson,
        queryParams: {
          "StallId": stall.autoNo,
        },
      );
      _satllVisitList = res.value ?? [];
      setState(() {});
    } on DioCustomException catch (e) {
      context.showSnackBarMessage(e.message);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> addStallVisitEntry(String qrEntry) async {
    final qrData = parseQrData(qrEntry);

    if (qrData == null) {
      context.showSnackBarMessage("Invalid QR Code");
      return;
    }

    try {
      LoadingScreen.instance().show(context: context);
      final stall = StaticVariable.loginUserDetail;
      // [data.RegNo, data.Name, data.OrganizationName, data.EmailId]

      final stallData = StallVisitEntryResDataModel(
        stallId: stall.autoNo,
        stallName: stall.name,
        registrationDate: DateTime.now().formatDate,
        visitorRegNo: int.tryParse(qrData.registrationNo),
        visitorName: qrData.fullName,
        visitorOrganization: qrData.organisation,
        visitorEmailId: qrData.email,
        visitorMobileNo: qrData.mobile,
        visitorDesignation: qrData.designation,
      );

      final res = await ApiService.instance.setData(
        endpoint: "${APIEndPoint.stallVisitEntry}/Post",
        data: stallData.toJson(),
        converter: StallVisitEntryResDataModel.fromJson,
      );

      setState(() {
        _satllVisitList = [res, ..._satllVisitList];
      });

      context.showSnackBarMessage("Visit entry added successfully", isInfo: false, isError: false);
    } on DioCustomException catch (e) {
      context.showSnackBarMessage(e.message);
    } finally {
      LoadingScreen.instance().hide();
    }
  }
}

QrUserData? parseQrData(String qrEntry) {
  if (qrEntry.trim().isEmpty) return null;

  final lines = qrEntry.split("\n");

  final Map<String, String> dataMap = {};

  for (final line in lines) {
    if (!line.contains(":")) continue;

    final parts = line.split(":");
    if (parts.length < 2) continue;

    final key = parts[0].trim().toLowerCase();
    final value = parts.sublist(1).join(":").trim();

    dataMap[key] = value;
  }

  // Validation
  if (!dataMap.containsKey("registration no") || !dataMap.containsKey("full name") || !dataMap.containsKey("organisation name") || !dataMap.containsKey("mobile no.") || !dataMap.containsKey("designation")) {
    return null;
  }

  return QrUserData(
    registrationNo: dataMap["registration no"] ?? "",
    fullName: dataMap["full name"] ?? "",
    organisation: dataMap["organisation name"] ?? "",
    mobile: dataMap["mobile no."] ?? "",
    designation: dataMap["designation"] ?? "",
    email: dataMap["email id"] ?? "",
  );
}

class QrUserData {
  final String registrationNo;
  final String fullName;
  final String organisation;
  final String mobile;
  final String designation;
  final String email;

  QrUserData({
    required this.registrationNo,
    required this.fullName,
    required this.organisation,
    required this.mobile,
    required this.designation,
    required this.email,
  });
}
