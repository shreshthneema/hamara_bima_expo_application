import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../constants.dart";

extension FormatDate on DateTime {
  String get formatDate => DateFormat("yyyy-MM-dd").format(this);
  String get formatDateForBOD => DateFormat("dd/MM/yyyy").format(this);
  String get formatDateInv => DateFormat("dd/MM/yy").format(this);

  // String get formatDateTime => DateFormat('yyyy/MM/dd h:mm a').format(this);

  String get formatTime => DateFormat("h:mm a").format(toLocal());
  String get formatMonth => DateFormat("MMMM").format(toLocal());
  String get formatTimeWithSeconds => DateFormat("hh:mm:ss a").format(toLocal());

  // String get formatDayDate => DateFormat('EEE, dd MMM yyyy').format(this);

  // String get formatFullMonthName => DateFormat('dd MMM yyyy').format(this);
  // String get formatFullMonthName2 => DateFormat('dd MMMM, yyyy').format(this);
  String get formatDateTime => DateFormat("yyyy-MM-ddTHH:mm:ss").format(toLocal());

  String get formatDateNotify => DateUtilsFormat.getFormatDate(this);
  String get formatDateNotify2 => DateUtilsFormat.getFormatDateWithoutAdding(this);
  String get formatFullDateWithDay => DateFormat("EEE, MMM dd, yyyy").format(this); // Sat, Mar 9, 2024, 12:37 AM
  String get formatFullDate => DateFormat("MMM dd, yyyy").format(this); // Sat, Mar 9, 2024, 12:37 AM
  String get formatFullDateWithDayAndTime => DateFormat("EEE, MMM dd, yyyy, h:mm a").format(this); // Sat, Mar 9, 2024, 12:37 AM
}

extension TimeOfDayExtension on TimeOfDay {
  String get format24Hour => DateFormat("HH:mm:ss").format(
        DateTime(0, 0, 0, hour, minute),
      );
}

class DateUtilsFormat {
  static String todayDate = DateTime.now().formatDate;
  static String yesterdayDate = DateTime.now().subtract(const Duration(days: 1)).formatDate;
  static String getFormatDate(DateTime date) {
    var data = date.toLocal().formatDate;
    if (todayDate == data) return "Today";
    if (yesterdayDate == data) return "Yesterday";
    return data;
  }

  static String getFormatDateWithoutAdding(DateTime date) {
    var data = date.formatFullDateWithDay;
    if (todayDate == data) return "Today";
    if (yesterdayDate == data) return "Yesterday";
    return data;
  }

  static Future<DateTime?> selectDate(
    BuildContext context, {
    DateTime? selectedDate,
    required void Function(DateTime? selectedDate) onChange,
    DateTime? firstDate,
    DateTime? initialDate,
    DateTime? lastDate,
    bool addCheck = true,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? initialDate ?? DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: firstDate ?? DateTime(1950),
      lastDate: lastDate ?? DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor,
            ),
            // scaffoldBackgroundColor: ,
            datePickerTheme: DatePickerThemeData(
              backgroundColor: whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                fontSize: 8,
                color: whiteColor,
              ),
              bodyLarge: TextStyle(
                color: blackColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (!addCheck && picked != null && picked != selectedDate) {
      onChange(picked);
      FocusScope.of(context).unfocus();
    }
    return picked;
  }

  static Future<TimeOfDay?> selectTime(
    BuildContext context, {
    TimeOfDay? selectedTime,
    required void Function(TimeOfDay? selectedDate) onChange,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor,
              primary: primaryColor,
              onPrimary: whiteColor,
              surface: whiteColor,
              onSurface: blackColor,
              background: whiteColor,
              onBackground: blackColor,
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: whiteColor,
              dialBackgroundColor: lightGrayOne,
              hourMinuteColor: lightGrayOne,
              dayPeriodColor: whiteColor,
              dayPeriodTextColor: blackColor,
              // rangePickerBackgroundColor: whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      onChange(picked);
      FocusScope.of(context).unfocus();
    }
    return picked;
  }

  static String getTimeDifference(DateTime startTime, DateTime endTime) {
    /// Set the format that of the Date/Time that like to parse
    /// h - 12h in am/pm
    /// m - minute in hour
    /// a - am/pm marker
    /// See more format here: https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
    // var dateFormat =  DateFormat('h:ma');
    // DateTime durationStart =  dateFormat.format(startTime);
    // DateTime durationEnd =  dateFormat.parse(endTime);
    var difference = endTime.difference(startTime);
    return "${difference.inHours.toString().padLeft(2, '0')}:${(difference.inMinutes - (difference.inHours * 60)).toString().padLeft(2, '0')} hr";
  }

  static String getFormatDateString(String date) {
    String data = date;
    if (date.contains("T")) {
      data = date.split("T")[0];
    } else if (date.contains(" ")) {
      data = date.split(" ")[0];
    }
    return data;
  }

  static String getFormatDateString2(String date) {
    String data;
    data = DateFormat("d MMM y").format(DateTime.parse(date));
    return data;
  }

  static String getDayOfDate(String date) {
    var data = DateFormat("EEEE").format(DateTime.parse(date));
    return data;
  }

  static String getFormatedTime(String time) {
    // Parse the time string into a DateTime object
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);

    // Format the DateTime object into a 12-hour format
    String formattedTime = DateFormat("hh:mm a").format(parsedTime);

    return formattedTime;
  }

  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(1, "0");
    String days = duration.inDays.toString();
    String hours = twoDigits(duration.inHours.remainder(24));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    // String seconds = twoDigits(duration.inSeconds.remainder(60));
    if (days.isNotEmpty && days != "0") {
      return "${days}d ${hours}h ${minutes}m";
    }
    return "${hours}h ${minutes}m";
  }

  static String getCurrentFinancialYear({String combineBy = "-"}) {
    final currentDate = DateTime.now();
    final currentYear = currentDate.year;

    if (currentDate.month < 4) {
      return "${currentYear - 1}$combineBy${currentYear % 100}";
    } else {
      return "${currentYear % 100}$combineBy${(currentYear + 1) % 100}";
    }
  }
}
