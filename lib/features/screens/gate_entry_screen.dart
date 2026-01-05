import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:hamara_bima_expo_application/core/network/network.dart";
import "package:hamara_bima_expo_application/features/models/GateEntryResMainModel.dart";
import "package:hamara_bima_expo_application/features/screens/qr_scanner_screen.dart";
import "package:hamara_bima_expo_application/features/screens/stall_entry_screen.dart";
import "package:hamara_bima_expo_application/features/widgets/page_layout.dart";
import "package:hamara_bima_expo_application/utils/constants.dart";
import "package:hamara_bima_expo_application/utils/dialogs/loading_screen.dart";
import "package:hamara_bima_expo_application/utils/extensions/build_context_ext.dart";
import "package:hamara_bima_expo_application/utils/extensions/date_format.dart";

class GateEntryScreen extends StatefulWidget {
  const GateEntryScreen({super.key});

  @override
  State<GateEntryScreen> createState() => _GateEntryScreenState();
}

class _GateEntryScreenState extends State<GateEntryScreen> {
  @override
  void initState() {
    getGateEntry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: const SizedBox(),
        leadingWidth: 0,
        title: const Text("Gate Entry"),
      ),
      body: _loading
          ? const Center(
              child: SpinKitFadingCircle(color: primaryColor),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (_gateEntryList.isEmpty) Image.asset("assets/images/data-not-found.jpg"),
                  for (var data in _gateEntryList)
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: darkGreyOne,
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(color: data.isVerified == "Y" ? Colors.green : Colors.red, borderRadius: BorderRadius.circular(50)),
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            data.isVerified == "Y" ? Icons.check : Icons.close,
                            color: whiteColor,
                          ),
                        ),
                        title: Text("Reg No: ${data.regNo ?? 'N/A'}"),
                        subtitle: Text("Remarks: ${data.remarks ?? 'N/A'}"),
                        trailing: Text(data.createdAt != null ? (DateTime.tryParse(data.createdAt!)?.formatDateTime ?? "N/A") : "N/A"),
                      ),
                    ),
                ],
              ),
            ),
      from: "Gate Entry",
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
                  addGateEntry(data);
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

  List<GateEntryResDataModel> _gateEntryList = [];
  bool _loading = false;

  Future<void> getGateEntry() async {
    try {
      setState(() {
        _loading = true;
      });
      final res = await ApiService.instance.getDocumentData(
        endpoint: APIEndPoint.gateEntry,
        converter: GateEntryResMainModel.fromJson,
      );

      print(res.value?.length);
      setState(() {
        _gateEntryList = res.value ?? [];
      });
    } on DioCustomException catch (e) {
      context.showSnackBarMessage(e.message);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> addGateEntry(String qrEntry) async {
    try {
      LoadingScreen.instance().show(context: context);

      final stallData = GateEntryResDataModel(
        remarks: qrEntry,
        isVerified: "N",
      );
      final qrData = parseQrData(qrEntry);
      if (qrData != null) {
        stallData.regNo = qrData.registrationNo;
        stallData.isVerified = "Y";
      }

      final res = await ApiService.instance.setData(
        endpoint: "${APIEndPoint.gateEntry}/Post",
        data: stallData.toJson(),
        converter: GateEntryResDataModel.fromJson,
      );

      setState(() {
        _gateEntryList = [res, ..._gateEntryList];
      });

      context.showSnackBarMessage("Entry added successfully", isInfo: false, isError: false);
    } on DioCustomException catch (e) {
      context.showSnackBarMessage(e.message);
    } finally {
      LoadingScreen.instance().hide();
    }
  }
}
