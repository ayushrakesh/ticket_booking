import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_booking/widgets/hotel.dart';

import '../utils/app_styles.dart';

class AllHotelsScreen extends StatelessWidget {
  static const routeName = 'all-hotels';

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
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Hotels',
          style: Styles.headLineStyle1,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(
              right: width * 0.03, top: height * 0.02, bottom: height * 0.02),
          child: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var hotelsMap =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                var hotelsWidgets = hotelsMap.map((e) => Hotel(e)).toList();
                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14, childAspectRatio: 0.62,
                  children: hotelsWidgets,
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     // mainAxisExtent: 0.,

                  //     childAspectRatio: 0.62,
                  //     crossAxisCount: 2,
                  //     crossAxisSpacing: 0,
                  //     mainAxisSpacing: 20),
                  // itemBuilder: (ctx, index) {
                  //   return Hotel(hotels[index]);
                  // },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            stream: FirebaseFirestore.instance.collection('hotels').snapshots(),
          )),
    );
  }
}
