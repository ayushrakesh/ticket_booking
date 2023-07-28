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
  late Stream<QuerySnapshot> ticketsStream;

  CollectionReference ticketsRF =
      FirebaseFirestore.instance.collection('tickets');

  List tickets = [];

  bool isloading = false;

  @override
  void initState() {
    // getData();
    // ticketsStream = ticketsRF.snapshots();
    super.initState();
  }

  void getData() async {
    setState(() {
      isloading = true;
    });
    var data = await FirebaseFirestore.instance.collection('tickets').get();

    setState(() {
      isloading = true;
    });
    for (var doc in data.docs) {
      tickets.add(doc.data() as Map<String, dynamic>);
    }
    print(tickets.length);
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
                  // shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      var ds = snapshot.data!.docs[index];
                      // if (snapshot.data != null)
                      return Ticket(ds as Map<String, dynamic>);
                    }
                  },
                  itemCount: snapshot.data!.docs.length);
            } else {
              return Text('No data');
            }
          },
          stream: FirebaseFirestore.instance.collection('tickets').snapshots(),
        ),
        // child: isloading
        //     ? ListView.builder(
        //         itemBuilder: (ctx, index) {
        //           return Ticket(tickets[index]);
        //         },
        //         itemCount: tickets.length,
        //       )
        //     : Center(
        //         child: CircularProgressIndicator(),
        //       ),
      ),
    );
  }
}
