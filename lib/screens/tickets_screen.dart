import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ticket_booking/widgets/bar_code.dart';

import 'package:ticket_booking/widgets/dash_line.dart';
import '../data/ticket.dart';
import '../utils/app_styles.dart';
import '../widgets/ticket.dart';

class TicketsScreen extends StatelessWidget {
  final width = Get.width;
  final height = Get.height;

  List<Map<String, dynamic>> bookedTickets = [];

  @override
  Widget build(BuildContext context) {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;

    getBookedTicketDetails(BuildContext contex) async {
      var docs = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserID)
          .collection('booked-tickets')
          .get();
      List<Map<String, dynamic>> bookedTic =
          docs.docs.map((e) => e.data()).toList();
      bookedTickets = bookedTic;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.bgColor,
        elevation: 0,
        title: Text(
          'Tickets',
          style: Styles.headLineStyle2,
        ),
      ),
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.05),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.06,
                  width: width * 0.6,
                  child: FittedBox(
                    child: Container(
                      padding: const EdgeInsets.all(3.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFF4F6Fd),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Upcoming',
                              ),
                            ),
                            // width: width * 0.44,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(20),
                              ),
                            ),
                            child: const Center(
                              child: Text('Previous'),
                            ),
                            // width: width * 0.44,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(height * 0.05),
                ListView.builder(
                  itemBuilder: (context, index) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: Styles.headLineStyle3,
                              ),
                              const Gap(5),
                              Text(
                                'From',
                                style: Styles.headLineStyle4,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '5221 364869',
                                style: Styles.headLineStyle3,
                              ),
                              const Gap(5),
                              Text(
                                'passport',
                                style: Styles.headLineStyle4,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(height * 0.03),
                      const DashLines(true, 7, 5),
                      Gap(height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '364738 28274478',
                                style: Styles.headLineStyle3,
                              ),
                              const Gap(5),
                              Text(
                                'Number of e-tickets',
                                style: Styles.headLineStyle4,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'B2SG28',
                                style: Styles.headLineStyle3,
                              ),
                              const Gap(5),
                              Text(
                                'Booking code',
                                style: Styles.headLineStyle4,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(height * 0.03),
                      const DashLines(true, 7, 5),
                      Gap(height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/visa.png',
                                    scale: 11,
                                  ),
                                  Text(
                                    ' *** 2462',
                                    style: Styles.headLineStyle3,
                                  )
                                ],
                              ),
                              const Gap(5),
                              Text(
                                'Payment method',
                                style: Styles.headLineStyle4,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$249.99',
                                style: Styles.headLineStyle3,
                              ),
                              const Gap(5),
                              Text(
                                'Price',
                                style: Styles.headLineStyle4,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(height * 0.03),
                      const Divider(),

                      // DashLines(true, 7, 7),
                    ],
                  ),
                  itemCount: bookedTickets.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
