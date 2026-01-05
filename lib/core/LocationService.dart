// import "package:flutter/material.dart";
// import "package:geolocator/geolocator.dart";
// import "package:geocoding/geocoding.dart";
// import "package:hamara_bima_expo_application/utils/constants.dart";
// import "package:hamara_bima_expo_application/utils/extensions/string.dart";
//
// class LocationHelper {
//   static Future<(String?, (double, double))?> determineAddress(BuildContext context) async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       bool openSettings = await showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               backgroundColor: primaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               title: const Text("Location Required"),
//               content: const Text("Please enable location services to continue."),
//               actions: [
//                 TextButton(
//                   child: const Text(
//                     "Open Settings",
//                     style: TextStyle(
//                       color: whiteColor,
//                     ),
//                   ),
//                   onPressed: () => Navigator.of(context).pop(true),
//                 ),
//               ],
//             ),
//           ) ??
//           false;
//
//       if (openSettings == true) {
//         await Geolocator.openLocationSettings();
//       }
//       return null;
//     }
//
//     // Check permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return null;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Location permission is permanently denied")),
//       );
//       return null;
//     }
//
//     // Get coordinates
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     // Get address from coordinates
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       position.latitude,
//       position.longitude,
//     );
//
//     if (placemarks.isNotEmpty) {
//       Placemark place = placemarks.first;
//       print(place);
//       return ({place.name, place.subLocality, place.locality, place.subAdministrativeArea, place.administrativeArea, place.postalCode, place.country}.toList().combineNonNulls(", "), (position.latitude, position.longitude));
//     }
//
//     return null;
//   }
// }
