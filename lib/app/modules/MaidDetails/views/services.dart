// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:power_maids/Utils/global_text.dart';
// import 'package:power_maids/app/modules/MaidDetails/controllers/maid_details_controller.dart';
//
// class Services extends StatelessWidget {
//   const Services({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(MaidDetailsController());
//     final conttroller = MaidDetailsController();
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 80,
//           ),
//           Textwidget(
//             text: "Services",
//             fontWeight: FontWeight.w700,
//           ),
//           ListView.builder(
//               itemCount: conttroller.serviceslist.length,
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (BuildContext, index) {
//                 return ExpansionTile(
//                   shape: Border.all(),
//                   tilePadding: EdgeInsets.zero,
//                   title: Textwidget(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w700,
//                     text: conttroller.serviceslist[index],
//                   ),
//                   children: [],
//                 );
//               })
//         ],
//       ),
//     );
//   }
// }
