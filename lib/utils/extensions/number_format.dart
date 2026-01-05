import "package:intl/intl.dart";

// extension ShourtNumber on double? {
//   String get formatLargeNum => this == null
//       ? "0.00"
//       : this! < 100000 && this! > -100000
//           ? this!.toStringAsFixed(2)
//           : NumberFormat.compact(
//               locale: 'en_IN',
//             ).format(this!);
//
//   String get formatMediumNum => this == null
//       ? "0.00"
//       : this! < 10000 && this! > -10000
//           ? this!.toStringAsFixed(2)
//           : NumberFormat.compact(
//               locale: 'en_IN',
//             ).format(this!);
//
//   String get formatSmallNum => this == null
//       ? "0.00"
//       : NumberFormat.compact(
//           locale: 'en_IN',
//         ).format(this!.toInt());
// }

extension FormatNumber on double {
  String get format => NumberFormat("#,##,##0.00", "HI").format(this);
  String get formatAbs => NumberFormat("#,##,##0", "HI").format(this);
  String get formatIf => NumberFormat("#,##,##0.##", "HI").format(this);
}
