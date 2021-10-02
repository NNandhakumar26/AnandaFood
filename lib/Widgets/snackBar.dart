// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../Theme.dart';

// class TempNotification extends StatelessWidget {
//   const TempNotification({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       Get.snackbar(
//         'Response',
//         '{jsonDecode(response.body)[message]}',
//         duration: Duration(seconds: 10),
//         padding: EdgeInsets.all(16),
//         titleText: Text(
//           'Response',
//           style: Style.subtitle.copyWith(
//             color: Style.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         messageText: Text(
//           '{jsonDecode(response.body)[message]}',
//           style: Style.subtitle.copyWith(
//             color: Style.white,
//           ),
//         ),
//         colorText: Style.white,
//         borderRadius: 8,
//         backgroundColor: Style.accent[300]!.withOpacity(0.87),
//       ),
//     );
//   }
// }
