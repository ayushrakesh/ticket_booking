import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:ticket_booking/data/ticket.dart';
import 'package:ticket_booking/screens/all_hotels_screen.dart';
import 'package:ticket_booking/screens/all_tickets_screen.dart';
import '../data/hotel.dart';
import '../widgets/ticket.dart';
import '../widgets/hotel.dart';
import '../utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

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
                // SearchBar(
                //   padding: MaterialStateProperty.all(
                //     EdgeInsets.symmetric(
                //       horizontal: width * 0.05,
                //       // vertical: height * 0.02,
                //     ),
                //   ),
                //   leading: Icon(Icons.search),
                //   controller: searchController,
                //   onChanged: (value) {
                //     setState(() {
                //       searchText = value;
                //     });
                //   },
                //   hintText: 'Search tickets here',
                // ),
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
          Container(
            width: double.infinity,
            height: height * 0.28,
            child: StreamBuilder<QuerySnapshot>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var docs = snapshot.data!.docs;

                      var tickets = docs
                          .map((e) => e.data() as Map<String, dynamic>)
                          .toList();

                      print(tickets);
                      print(tickets.length);
                      print(tickets[2]);
                      return Ticket(tickets[index]);
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                } else {
                  return SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator());
                }
              },
              stream:
                  FirebaseFirestore.instance.collection('tickets').snapshots(),
            ),
          ),
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
                  onTap: () {
                    Navigator.of(context).pushNamed(AllHotelsScreen.routeName);
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
          ),
          Gap(height * 0.02),
          Container(
            width: double.infinity,
            height: height * 0.4,
            child: StreamBuilder<QuerySnapshot>(
              builder: (context, snapshot) {
                // print(snapshot.data!.docs.
                // length);

                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        print("done");
                        var hotels = snapshot.data!.docs
                            .map(
                              (e) => e.data() as Map<String, dynamic>,
                            )
                            .toList();
                        print(snapshot.data!.docs.length);

                        return Hotel(hotels[index] as Map<String, dynamic>);
                      },
                      itemCount: 3);
                } else {
                  return SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator());
                }
              },
              stream:
                  FirebaseFirestore.instance.collection('hotels').snapshots(),
            ),
          ),
          Gap(height * 0.04),
        ],
      ),
    );
  }
}
