import "package:hamara_bima_expo_application/features/models/StallRegsitryResMainModel.dart";
import "package:hamara_bima_expo_application/features/models/UserResMainModel.dart";

class StaticVariable {
  StaticVariable._();

  /// the one and only instance of this singleton
  static final instance = StaticVariable._();

  static String user = "";
  static String token = "";
  static String password = "";

  // static String BASE_URL = "https://127.0.0.1:7191/api/";
  // static String BASE_URL_Attah = "https://127.0.0.1:7191/uploads/";
  static String BASE_URL = "https://103.107.66.20:7443/api/";
  static String BASE_URL_Attah = "https://51.112.25.49:8443/uploads/";
  static StallRegsitryResDataModel loginUserDetail = StallRegsitryResDataModel();
}
