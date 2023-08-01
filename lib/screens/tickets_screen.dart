import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ticket_booking/screens/home_screen.dart';
import 'package:ticket_booking/widgets/bar_code.dart';
import 'package:ticket_booking/widgets/bottom_bar.dart';

import 'package:ticket_booking/widgets/dash_line.dart';
import '../data/ticket.dart';
import '../utils/app_styles.dart';
import '../widgets/ticket.dart';

class TicketsScreen extends StatefulWidget {
  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  final width = Get.width;

  bool isTicketExpanded = false;

  final height = Get.height;

  List<Map<String, dynamic>> bookedTickets = [];

  final currentUserID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(BottomNavigation.routeName);
          },
        ),
        backgroundColor: Styles.bgColor,
        elevation: 0,
        title: Text(
          'Tickets',
          style: Styles.headLineStyle2,
        ),
      ),
      backgroundColor: Styles.bgColor,
      body: Padding(
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
              StreamBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        // reverse: true,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(bottom: height * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(height * 0.03),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: Offset(16, 6),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: height * 0.02,
                                horizontal: width * 0.04),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]
                                              ['from-name'],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['to-name'],
                                          style: Styles.headLineStyle3,
                                        ),
                                        const Gap(5),
                                        Text(
                                          'Travelling to',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['number']
                                              .toString(),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${snapshot.data!.docs[index]['departure-date']}' +
                                              " "
                                                  '${snapshot.data!.docs[index]['departure-time']}',
                                          style: Styles.headLineStyle3,
                                        ),
                                        const Gap(5),
                                        Text(
                                          'Departure',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Rs. ${snapshot.data!.docs[index]['price-in-rupees']}'
                                              .toString(),
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
                                // Gap(height * 0.03),
                                // const Divider(),

                                // DashLines(true, 7, 7),
                              ],
                            ),
                          ),
                        ),
                        itemCount: snapshot.data!.docs.length,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUserID)
                    .collection('booked-tickets')
                    .snapshots(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
