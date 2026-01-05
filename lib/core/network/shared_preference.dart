import "package:shared_preferences/shared_preferences.dart";

class SharedPreference {
  static SharedPreferences? localStorage;

  static Future init() async {}

  static String cardCode = "cardCode";
  static String passwordCreated = "PasswordCreated";
  static String joinKey = "joinKey";
  static String phoneNumber = "phoneNumber";
  static String groupNum = "GroupNum";
  static String cardName = "cardName";
  static String isOnboarded = "isOnboarded";
  static String balance = "balance";
  static String branch = "branch";
  static String selectedSize = "size";
  static String cartUpdate = "cartUpdate";

  static String otp = "OTP";
  static String fcmToken = "FcmToken";
  static String viewedOrder = "ClearOrder";

  static void setSharedPreference(String key, String value) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage!.setString(key, value);
  }

  static Future<String> test(String key) async {
    String value = "";
    localStorage = await SharedPreferences.getInstance();
    value = localStorage!.getString(key).toString();
    return value;
  }

  static Future<String> getSharePreferenceValue(String key) async {
    String value = "";
    localStorage = await SharedPreferences.getInstance();
    value = localStorage!.getString(key).toString();
    return value;
  }
}
