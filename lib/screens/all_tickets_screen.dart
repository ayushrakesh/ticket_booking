import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/ticket.dart';

class AllTicketsScreen extends StatefulWidget {
  static const routename = 'all-tickets';

  @override
  State<AllTicketsScreen> createState() => _AllTicketsScreenState();
}

class _AllTicketsScreenState extends State<AllTicketsScreen> {
  @override
  void initState() {
    // getData();
    // ticketsStream = ticketsRF.snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.05),
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
                    var tickets = snapshot.data!.docs
                        .map(
                          (e) => e.data() as Map<String, dynamic>,
                        )
                        .toList();
                    print(snapshot.data!.docs.length);

                    return Ticket(tickets[index]);
                  },
                  itemCount: snapshot.data!.docs.length);
            } else {
              return CircularProgressIndicator();
            }
          },
          stream: FirebaseFirestore.instance.collection('tickets').snapshots(),
        ),
      ),
    );
  }
}
