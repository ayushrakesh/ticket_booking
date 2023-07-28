import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ticket_booking/utils/app_styles.dart';

import '../widgets/ticket.dart';

class AllTicketsScreen extends StatelessWidget {
  static const routename = 'all-tickets';

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
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
              return const CircularProgressIndicator();
            }
          },
          stream: FirebaseFirestore.instance.collection('tickets').snapshots(),
        ),
      ),
    );
  }
}
