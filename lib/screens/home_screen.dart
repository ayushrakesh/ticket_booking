import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:ticket_booking/data/ticket.dart';
import 'package:ticket_booking/screens/all_tickets_screen.dart';
import '../data/hotel.dart';
import '../widgets/ticket.dart';
import '../widgets/hotel.dart';
import '../utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<QuerySnapshot> ticketsStream;

  CollectionReference ticketsRF =
      FirebaseFirestore.instance.collection('tickets');

  @override
  void initState() {
    ticketsStream = ticketsRF.snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    List<QueryDocumentSnapshot> tickets = [];

    void getTickets() async {
      final data = await FirebaseFirestore.instance
          .collection('tickets')
          .get()
          .then((value) {
        for (var doc in value.docs) {
          tickets.add(doc);
          print('heollo');
        }
      });
      print(data.docs.length);
    }

    @override
    void initState() {
      getTickets();
      super.initState();
    }

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: [
          Container(
            // padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),

            child: Column(
              children: [
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style: Styles.headLineStyle3,
                        ),
                        const Gap(5),
                        Text(
                          'Book Tickets',
                          style: Styles.headLineStyle1,
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/img_1.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(25),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6FD),
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        FluentIcons.search_24_regular,
                        color: Color(0xFFBFC205),
                      ),
                      Text(
                        'Search',
                        style: Styles.headLineStyle4,
                      ),
                    ],
                  ),
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upcoming Flights',
                      style: Styles.headLineStyle2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AllTicketsScreen.routename);
                      },
                      child: Text(
                        'View all',
                        style: Styles.textStyle.copyWith(
                          color: Styles.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(height * 0.02),
          // Container(
          //   width: double.infinity,
          //   // padding: const EdgeInsets.only(
          //   //   right: 16,
          //   // ),
          //   // scrollDirection: Axis.horizontal,
          //   child: StreamBuilder<QuerySnapshot>(
          //     builder: (context, snapshot) {
          //       // print(snapshot.data!.docs.
          //       // length);
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (context, index) {
          //           if (snapshot.connectionState == ConnectionState.waiting) {
          //             return CircularProgressIndicator();
          //           }
          //           if (snapshot.connectionState == ConnectionState.done) {
          //             return Ticket(
          //                 snapshot.data!.docs[index] as Map<String, dynamic>);
          //           }
          //         },
          //         itemCount: snapshot.data!.docs.length,
          //       );
          //     },
          //     stream: ticketsStream,
          //   ),
          // ),
          // child: StreamBuilder(
          //   builder: (context, snapshot) {
          //     return ListView.builder(
          //       itemBuilder: (context, index) {
          //         return Ticket(snapshot.data!.docs[index]);
          //       },
          //       itemCount: snapshot.data!.docs.length,
          //     );
          //   },
          //   stream:
          //       FirebaseFirestore.instance.collection('tickets').snapshots(),
          // ),

          // TextButton(onPressed: getTickets, child: Text("get")),
          Gap(height * 0.05),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hotels',
                  style: Styles.headLineStyle2,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'View all',
                    style: Styles.textStyle.copyWith(
                      color: Styles.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(right: width * 0.04),
            child: Row(
              children: hotelList.map((e) => Hotel(e)).toList(),
            ),
          ),
          Gap(height * 0.04),
        ],
      ),
    );
  }
}
