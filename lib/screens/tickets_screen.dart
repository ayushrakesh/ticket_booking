// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:ticket_booking/widgets/bar_code.dart';

// import 'package:ticket_booking/widgets/dash_line.dart';
// import '../data/ticket.dart';
// import '../utils/app_styles.dart';
// import '../widgets/ticket.dart';

// class TicketsScreen extends StatelessWidget {
//   final width = Get.width;
//   final height = Get.height;

//   TicketsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Styles.bgColor,
//       body: Stack(
//         children: [
//           ListView(
//             padding: EdgeInsets.symmetric(
//                 horizontal: width * 0.08, vertical: height * 0.03),
//             children: [
//               Gap(height * 0.04),
//               Text(
//                 'Tickets',
//                 style: Styles.headLineStyle1,
//               ),
//               Gap(height * 0.02),
//               SizedBox(
//                 height: height * 0.06,
//                 // width: width * 0.6,
//                 child: FittedBox(
//                   child: Container(
//                     padding: const EdgeInsets.all(3.5),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: const Color(0xFFF4F6Fd),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 32, vertical: 8),
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.horizontal(
//                               left: Radius.circular(20),
//                             ),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               'Upcoming',
//                             ),
//                           ),
//                           // width: width * 0.44,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 32, vertical: 8),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade200,
//                             borderRadius: const BorderRadius.horizontal(
//                               right: Radius.circular(20),
//                             ),
//                           ),
//                           child: const Center(
//                             child: Text('Previous'),
//                           ),
//                           // width: width * 0.44,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Gap(height * 0.03),
//               Container(
//                 child: Ticket(
//                   ticketList[0],
//                   isColor: true,
//                 ),
//               ),
//               const SizedBox(height: 1),
//               Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(21),
//                     bottomRight: Radius.circular(21),
//                   ),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                     horizontal: width * 0.03, vertical: height * 0.03),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Flutter DB',
//                               style: Styles.headLineStyle3,
//                             ),
//                             const Gap(5),
//                             Text(
//                               'Passenger',
//                               style: Styles.headLineStyle4,
//                             ),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               '5221 364869',
//                               style: Styles.headLineStyle3,
//                             ),
//                             const Gap(5),
//                             Text(
//                               'passport',
//                               style: Styles.headLineStyle4,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Gap(height * 0.03),
//                     const DashLines(true, 7, 5),
//                     Gap(height * 0.03),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '364738 28274478',
//                               style: Styles.headLineStyle3,
//                             ),
//                             const Gap(5),
//                             Text(
//                               'Number of e-tickets',
//                               style: Styles.headLineStyle4,
//                             ),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               'B2SG28',
//                               style: Styles.headLineStyle3,
//                             ),
//                             const Gap(5),
//                             Text(
//                               'Booking code',
//                               style: Styles.headLineStyle4,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Gap(height * 0.03),
//                     const DashLines(true, 7, 5),
//                     Gap(height * 0.03),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/images/visa.png',
//                                   scale: 11,
//                                 ),
//                                 Text(
//                                   ' *** 2462',
//                                   style: Styles.headLineStyle3,
//                                 )
//                               ],
//                             ),
//                             const Gap(5),
//                             Text(
//                               'Payment method',
//                               style: Styles.headLineStyle4,
//                             )
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               '\$249.99',
//                               style: Styles.headLineStyle3,
//                             ),
//                             const Gap(5),
//                             Text(
//                               'Price',
//                               style: Styles.headLineStyle4,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Gap(height * 0.03),
//                     const Divider(),
//                     Gap(height * 0.03),
//                     Container(
//                       decoration: const BoxDecoration(color: Colors.white),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: BarCode(),
//                       ),
//                       // padding: EdgeInsets.symmetric(
//                       //     horizontal: width * 0.06, vertical: height * 0.03),
//                     ),
//                     // DashLines(true, 7, 7),
//                   ],
//                 ),
//               ),
//               Gap(height * 0.04),
//               ,
//             ],
//           ),
//           Positioned(
//             left: width * 0.06,
//             top: height * 0.4,
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Styles.textColor, width: 2),
//               ),
//               child: Container(
//                 padding: const EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(width: 0.1, color: Styles.textColor)),
//                 child: const CircleAvatar(
//                   maxRadius: 4,
//                   backgroundColor: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             right: width * 0.06,
//             top: height * 0.4,
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Styles.textColor, width: 2),
//               ),
//               child: Container(
//                 padding: const EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(width: 0.1, color: Styles.textColor)),
//                 child: const CircleAvatar(
//                   maxRadius: 4,
//                   backgroundColor: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
