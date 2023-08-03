import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ticket_booking/screens/payment_screen.dart';
import 'package:ticket_booking/utils/app_styles.dart';

import '../widgets/ticket.dart';
import '../widgets/tickets_details.dart';

class AllTicketsScreen extends StatefulWidget {
  static const routename = 'all-tickets';

  @override
  State<AllTicketsScreen> createState() => _AllTicketsScreenState();
}

class _AllTicketsScreenState extends State<AllTicketsScreen> {
  final seatsController = TextEditingController();

  final fromController = TextEditingController();
  final toController = TextEditingController();

  final width = Get.width;
  final height = Get.height;

  String from = '';
  String to = '';

  int noOfSeats = 0;
  // int singleTicketPrice = 0;
  int price = 0;

  List fromFilteredTickets = [];
  List toFilteredTickets = [];
  List filteredTickets = [];

  @override
  Widget build(BuildContext context) {
    void showBottomModal(BuildContext context, Map<String, dynamic> ticket) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (ctx) {
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.04),
              height: height * 0.4,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'From',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            ticket['from-name'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'To',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            ticket['to-name'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Gap(height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      Text(
                        ticket['date'],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Gap(height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Seats to book',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      SizedBox(
                        width: width * 0.04,
                        child: TextField(
                          controller: seatsController,
                          onChanged: (value) {
                            setState(() {
                              noOfSeats = int.parse(value);
                            });

                            // print(noOfSeats);
                          },
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  Gap(height * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.2, vertical: height * 0.02),
                      backgroundColor: Colors.purple,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      print(noOfSeats);

                      print(ticket['price']);

                      print(price);

                      if (noOfSeats <= ticket['number'] && noOfSeats >= 1) {
                        seatsController.clear();

                        Navigator.of(context)
                            .pushNamed(PaymentScreen.routeName, arguments: {
                          'ticket': ticket,
                          'seats': noOfSeats,
                          'ticket-id': ticket['id'],
                          'initial-price': noOfSeats * ticket['price']
                        });
                      }
                    },
                    child: const Text(
                      'Go for payment',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            );
          },
          isDismissible: true);
    }

    void fromFetch(String fromtext) async {
      setState(() {
        from = fromtext;
      });

      QuerySnapshot allTicketss =
          (await FirebaseFirestore.instance.collection('tickets').get());

      var alltickets = allTicketss.docs
          .map((e) => e.data() as Map<String, dynamic>)
          .toList();

      var results = alltickets
          .where((element) =>
              element['from-name'].toLowerCase().contains(from.toLowerCase()))
          .toList();

      setState(() {
        fromFilteredTickets = results;
      });

      print(fromFilteredTickets);
      print(fromFilteredTickets.length);
    }

    void toFetch(String totext) async {
      setState(() {
        to = totext;
      });

      var allTickets = [];

      QuerySnapshot allTicketss =
          (await FirebaseFirestore.instance.collection('tickets').get());

      var alltickets =
          allTicketss.docs.map((e) => e.data() as Map<String, dynamic>);

      var results = alltickets
          .where((element) => element['to-name']
              .toString()
              .toLowerCase()
              .contains(to.toLowerCase()))
          .toList();

      setState(() {
        toFilteredTickets = results;
      });

      print(toFilteredTickets.length);
      print(toFilteredTickets);
    }

    void filterTickets() {
      FocusScope.of(context).unfocus();

      var lists = [...fromFilteredTickets, ...toFilteredTickets];

      fromFilteredTickets
          .removeWhere((element) => toFilteredTickets.contains(element));

      setState(() {
        filteredTickets = fromFilteredTickets;
      });

      print(lists);
      print(filteredTickets);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Tickets',
          style: Styles.headLineStyle1.copyWith(fontSize: 22),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          // top: height * 0.02,
          // bottom: height * 0.02,
          right: width * 0.02,
          left: width * 0.02,
        ),
        child: Column(
          children: [
            // Gap(height * 0.02),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.04),
                  child: Text(
                    'Search tickets',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.02,
                horizontal: width * 0.06,
              ),
              child: TextField(
                controller: fromController,
                onChanged: (value) {
                  fromFetch(value.trim());
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: height * 0.00,
                    horizontal: width * 0.05,
                  ),
                  hintText: 'From',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
              ),
            ),
            // Gap(height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(
                // vertical: height * 0.02,
                horizontal: width * 0.06,
              ),
              child: TextField(
                controller: toController,
                onChanged: (value) {
                  toFetch(value.trim());
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: height * 0.00,
                    horizontal: width * 0.05,
                  ),
                  hintText: 'To',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
              ),
            ),
            Gap(height * 0.03),
            Container(
              // padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              width: width * 0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      13,
                    ),
                  ),
                  backgroundColor: Color.fromARGB(255, 115, 9, 160),
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.02,
                  ),
                ),
                onPressed: () {
                  filterTickets();
                },
                child: Text(
                  'Find tickets',
                  style: Styles.textStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
            Gap(height * 0.02),
            filteredTickets.isEmpty
                ? Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              // padding: EdgeInsets.all(12),
                              itemBuilder: (context, index) {
                                print("done");
                                var tickets = snapshot.data!.docs
                                    .map(
                                      (e) => e.data() as Map<String, dynamic>,
                                    )
                                    .toList();
                                print(snapshot.data!.docs.length);

                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Ticket(tickets[index]),
                                        Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            showBottomModal(
                                                context, tickets[index]);
                                          },
                                          child: const Text(
                                            'Book \nnow',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider()
                                  ],
                                );
                              },
                              itemCount: snapshot.data!.docs.length);
                        } else {
                          return SizedBox(
                              height: height * 0.05,
                              width: height * 0.05,
                              child: const CircularProgressIndicator());
                        }
                      },
                      stream: FirebaseFirestore.instance
                          .collection('tickets')
                          .snapshots(),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Ticket(filteredTickets[index]),
                                Spacer(),
                                TextButton(
                                  onPressed: () {
                                    showBottomModal(
                                        context, filteredTickets[index]);
                                  },
                                  child: const Text(
                                    'Book \nnow',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        );
                      },
                      itemCount: filteredTickets.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
