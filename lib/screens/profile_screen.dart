import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ticket_booking/utils/app_styles.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final height = Get.height;
  final width = Get.width;

  String username = '';

  var currentUserId = FirebaseAuth.instance.currentUser!.uid;

  bool isLoading = false;
  bool logoutWaiting = false;

  DocumentReference userData = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  void showLogoutAlert() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
            contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.02),
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Are you sure?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Gap(height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                          onPressed: signOut,
                          child: Text(
                            'Yes',
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No'),
                      ),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }

  void signOut() async {
    Navigator.of(context).pop();
    setState(() {
      logoutWaiting = true;
    });

    FirebaseAuth.instance.signOut();

    setState(() {
      logoutWaiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        children: [
          Gap(height * 0.04),
          Row(
            children: [
              Container(
                height: height * 0.12,
                width: width * 0.20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/img_1.png'),
                  ),
                ),
              ),
              Gap(width * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Book Tickets',
                    style: Styles.headLineStyle1,
                  ),
                  Gap(height * 0.005),
                  Text(
                    'New Delhi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Gap(height * 0.005),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.010, vertical: height * 0.006),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFFEF4F3),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(width * 0.006),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF526799),
                          ),
                          child: const Icon(
                            FluentIcons.shield_24_filled,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        Gap(height * 0.005),
                        const Text(
                          'Premium Status',
                          style: TextStyle(
                              color: Color(0xFF526799),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
            ],
          ),
          Gap(height * 0.01),
          Divider(color: Colors.grey.shade400),
          Gap(height * 0.02),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: height * 0.14,
                decoration: BoxDecoration(
                  color: Styles.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Positioned(
                right: -(width * 0.14),
                top: -(height * 0.09),
                child: Container(
                  padding: EdgeInsets.all(width * 0.10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 16,
                      color: const Color(0xFF264Cd2),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.03, horizontal: width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      maxRadius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(
                        FluentIcons.lightbulb_24_filled,
                        color: Styles.primaryColor,
                        size: 27,
                      ),
                    ),
                    Gap(width * 0.05),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You\'ve got a new award',
                          style: Styles.headLineStyle2.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          'You have 95 flights in a year',
                          style: Styles.headLineStyle2.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Gap(height * 0.04),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'Profile',
                    style: Styles.headLineStyle2,
                  ),
                ],
              ),
              Gap(height * 0.02),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: Styles.headLineStyle4.copyWith(fontSize: 16),
                      ),
                      Text(
                        'Email',
                        style: Styles.headLineStyle4.copyWith(fontSize: 16),
                      )
                    ],
                  ),
                  Gap(width * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            var data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Text(
                              data['username'],
                              style:
                                  Styles.headLineStyle3.copyWith(fontSize: 14),
                            );
                          }

                          return SizedBox(
                            height: height * 0.02,
                            width: height * 0.02,
                            child: const CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          );
                        },
                        future: userData.get(),
                      ),
                      FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            var data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Text(
                              data['email'],
                              style:
                                  Styles.headLineStyle3.copyWith(fontSize: 14),
                            );
                          }

                          return SizedBox(
                            height: height * 0.02,
                            width: height * 0.02,
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          );
                        },
                        future: userData.get(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Gap(height * 0.04),
          Text(
            'Accumulated miles',
            style: Styles.headLineStyle2,
          ),
          Gap(height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            decoration: BoxDecoration(
              color: Styles.bgColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              children: [
                FutureBuilder(
                  builder: (ctx, future) {
                    if (future.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    num totalMiles = 0;
                    var ls = future.data!.docs.map(
                      (e) {
                        return int.parse(e.data()['flying-distance']);
                      },
                    ).toList();

                    ls.forEach((element) {
                      totalMiles = totalMiles + element;
                    });

                    return Text(
                      totalMiles.toString(),
                      style: TextStyle(
                        fontSize: 45,
                        color: Styles.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUserId)
                      .collection('booked-tickets')
                      .get(),
                ),
                Gap(height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Distance accrued',
                      style: Styles.headLineStyle4.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMd().format(DateTime.now()),
                      style: Styles.headLineStyle4.copyWith(
                          fontSize: 18,
                          color: Color.fromARGB(255, 115, 5, 149)),
                    ),
                  ],
                ),
                StreamBuilder(
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: double.infinity,
                        height: snapshot.data!.docs.length * height * 0.1,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot
                                        .data!.docs[index]['flying-distance']
                                        .toString(),
                                    style: Styles.headLineStyle3,
                                  ),
                                  const Gap(5),
                                  Text(
                                    'kilometers',
                                    style: Styles.headLineStyle4,
                                  ),
                                  Gap(height * 0.02),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['flight-name'],
                                    style: Styles.headLineStyle3,
                                  ),
                                  const Gap(5),
                                  Text(
                                    'Received from',
                                    style: Styles.headLineStyle4,
                                  ),
                                  Gap(height * 0.02),
                                ],
                              ),
                            ],
                          ),
                          itemCount: snapshot.data!.docs.length,
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUserId)
                      .collection('booked-tickets')
                      .snapshots(),
                )
                // StreamBuilder(
                //   builder: (ctx, stream) => Expanded(
                //     child: ListView.builder(
                //       shrinkWrap: true,
                //       itemBuilder: (ctx, index) => Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 stream.data!.docs[index]['flying-distance'].toString(),
                //                 style: Styles.headLineStyle3,
                //               ),
                //               const Gap(5),
                //               Text(
                //                 'kilometers',
                //                 style: Styles.headLineStyle4,
                //               ),
                //             ],
                //           ),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.end,
                //             children: [
                //               Text(
                //                 stream.data!.docs[index]['flight-name'],
                //                 style: Styles.headLineStyle3,
                //               ),
                //               const Gap(5),
                //               Text(
                //                 'Received from',
                //                 style: Styles.headLineStyle4,
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //       itemCount: 2,
                //     ),
                //   ),
                //   stream: FirebaseFirestore.instance
                //       .collection('users')
                //       .doc(currentUserId)
                //       .collection('booked-tickets')
                //       .snapshots(),
                // ),
              ],
            ),
          ),
          Gap(height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // width: width * 0.5,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(width * 0.1),
            // ),
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 12.0,
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.028, horizontal: width * 0.1),
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      width * 0.1,
                    ),
                  ),
                ),
                onPressed: showLogoutAlert,
                child: !logoutWaiting
                    ? const Text(
                        'Logout',
                        style: TextStyle(letterSpacing: 0.8),
                      )
                    : const CircularProgressIndicator(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
