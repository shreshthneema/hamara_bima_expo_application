extension StringExtension on String {
  // bool get isValidEmail => Regexes.emailRegex.hasMatch(this);
  //
  // //* An extension for validating String is a name.
  // bool get isValidName => Regexes.nameRegex.hasMatch(this);
  //
  // //* An extension for validating String is a contact.
  // bool get isValidContact => Regexes.contactRegex.hasMatch(this);
  //
  // //* An extension for validating String is a Zipcode.
  // bool get isValidZipCode => Regexes.zipCodeRegex.hasMatch(this);

  //* An extension for converting String to Capital case.
  String get capitalize => this[0].toUpperCase() + substring(1).toLowerCase();

  String capitalizeSentence() {
    var li = split(" ");
    var data = li.map((element) => element[0].toUpperCase() + element.substring(1).toLowerCase());
    return data.join(" ");
  }

  String capitalizeCC() {
    var data = this[0].toUpperCase() + substring(1);
    RegExp regex = RegExp(r"([a-z])([A-Z])");

    String result = data.replaceAllMapped(regex, (match) {
      return "${match.group(1)} ${match.group(2)}";
    });

    return result;
  }

  String get capitalizeSen => capitalizeSentence();
  String get capitalizeCamelCase => capitalizeCC();

  //* An extension for replacing underscores in a String with spaces.
  String get removeUnderScore => replaceAll("_", " ");

  String get breakString {
    final pattern = RegExp("([a-z])([A-Z])");
    return replaceAllMapped(pattern, (match) => "${match[1]} ${match[2]}");
  }
  //
  // String get toIn {
  //   return ((double.tryParse(this) ?? 0) * 0.39370079).round().toString();
  // }
  //
  // String get toCm {
  //   return ((double.tryParse(this) ?? 0) * 2.54).round().toString();
  // }

  String get getName {
    if (length < 2) return "";
    var splitN = split(" ");
    if (splitN.length >= 2 && splitN[0].isNotEmpty && splitN[1].isNotEmpty) {
      return splitN[0][0] + splitN[1][0];
    } else {
      return substring(0, 2);
    }
  }
}

extension ShowString on String? {
  String get show => this != null && this!.isNotEmpty ? this! : "";
  String get showNotAval => this != null && this!.isNotEmpty ? this! : "N/A";
}

extension ClacGst on double? {
  double? calculateGSTFromGst(String? price) {
    if ((price == null || double.tryParse(price) == null) || this == null) {
      return 0;
    }
    var priceP = double.parse(price);

    return (priceP * this!) / 100;
  }

  double? calculateGSTFromPrice(String? gst) {
    if ((gst == null || double.tryParse(gst) == null) || this == null) {
      return 0;
    }
    var gstP = double.parse(gst);

    return (gstP * this!) / 100;
  }

  double? calculateGSTFromPriceDouble(double? gst) {
    if (gst == null || this == null) {
      return 0;
    }

    return (gst * this!) / 100;
  }

  double? calculateTotalWithGstFromPrice(double? gst) {
    if (gst == null || this == null) {
      return 0;
    }

    return this! + ((gst * this!) / 100);
  }
}

extension CombineNonNull on List<String?> {
  String? combineNonNulls(String separator) {
    String? buffer;
    if (isEmpty) return null;
    if (length == 1) {
      return first;
    } else {
      buffer = first != null && first!.isNotEmpty ? first : "";
    }
    for (var i = 1; i < length; i++) {
      if (this[i] != null && this[i]!.isNotEmpty) {
        if (buffer != null && buffer.isNotEmpty) {
          buffer = '$buffer$separator';
        }
        buffer = buffer! + this[i]!;
      }
    }
    return buffer?.toString();
  }
}
