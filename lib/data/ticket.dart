import 'package:cloud_firestore/cloud_firestore.dart';

class Tickets {
  void initState() {
    uploadData();
  }

  List<Map<String, dynamic>> ticketList = [
    {
      // 'from': {
      //   'code': "NYC",
      //   'name': "New-York",
      // },
      'from-code': 'NYC',
      'from-name': "New-York",
      'to-code': "LDN",
      "to-name": "London",
      // 'to': {
      //   'code': "LDN",
      //   'name': "London",
      // },
      'flying_time': '8H 30M',
      'date': "1 MAY",
      'departure_time': "08:00 AM",
      "number": 23,
    },
    {
      // 'from': {
      //   'code': "DK",
      //   'name': "Dhaka",
      // },
      // 'to': {
      //   'code': "SH",
      //   'name': "Shanghai",
      // },
      'from-code': "DK",
      "from-name": "Dhaka",
      "to-code": "SH",
      "to-name": "Shanghai",
      'flying_time': '4H 20M',
      'date': "10 MAY",
      'departure_time': "09:00 AM",
      "number": 45,
    },
  ];

  uploadData() async {
    await FirebaseFirestore.instance
        .collection('tickets')
        .doc()
        .set(ticketList[0]);
  }
}
