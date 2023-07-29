import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ticket_booking/screens/payment_screen.dart';
import 'package:ticket_booking/utils/app_styles.dart';

import '../widgets/ticket.dart';

class AllTicketsScreen extends StatefulWidget {
  static const routename = 'all-tickets';

  @override
  State<AllTicketsScreen> createState() => _AllTicketsScreenState();
}

class _AllTicketsScreenState extends State<AllTicketsScreen> {
  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    final seatsController = TextEditingController();

    int noOfSeats = 0;

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
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                          Text(ticket['from-name'])
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'To',
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                          Text(ticket['to-name'])
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
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      Text(ticket['date']),
                    ],
                  ),
                  Gap(height * 0.05),
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        print(noOfSeats);

                        if (noOfSeats <= int.parse(ticket['number'])) {
                          seatsController.clear();
                          seatsController.text = '';

                          noOfSeats = 0;
                          Navigator.of(context)
                              .pushNamed(PaymentScreen.routeName);
                        }
                      },
                      child: const Text('Go for payment'))
                ],
              ),
            );
          },
          isDismissible: true);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Tickets',
          style: Styles.headLineStyle1,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: height * 0.02,
            bottom: height * 0.02,
            right: width * 0.06,
            left: width * 0.02),
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
                                  showBottomModal(context, tickets[index]);
                                },
                                child: Text('Book \nnow'))
                          ],
                        ),
                        Divider()
                      ],
                    );
                  },
                  itemCount: snapshot.data!.docs.length);
            } else {
              return const CircularProgressIndicator();
            }
          },
          stream: FirebaseFirestore.instance.collection('tickets').snapshots(),
        ),
      ),
    );
  }
}
