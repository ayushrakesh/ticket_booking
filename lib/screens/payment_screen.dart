import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../utils/app_styles.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = 'payment';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _razorpay = Razorpay();

  final amountController = TextEditingController();

  int amount = 0;

  final width = Get.width;
  final height = Get.height;

  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  var newTicket;
  var seats;
  var ticketId;

  String? paymentId;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Navigator.of(context).pop();
    addBookedTicket();
    print(response.orderId);
    // print(response.)
    paymentId = response.paymentId;
    print(response.paymentId);
    // print(response.message);
    // print(response.error);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Navigator.of(context).pop();

    print(response.code);
    print(response.message);
    print(response.error);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Navigator.of(context).pop();
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void addBookedTicket() async {
    var newTk = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('booked-tickets')
        .add({
      'from-code': newTicket['from-code'],
      'from-name': newTicket['from-name'],
      'to-code': newTicket['to-code'],
      'to-name': newTicket['to-name'],
      'booking-time': DateTime.now(),
    });

    print(ticketId);
    print(seats);

    var updatedTk = await FirebaseFirestore.instance
        .collection('tickets')
        .where('id', isEqualTo: ticketId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data().length);
        // print(element.data());
        element.data().update('number', (value) => (value - seats));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    newTicket = args['ticket'];
    seats = args['seats'];
    ticketId = args['ticket-id'];

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
          'Payment',
          style: Styles.headLineStyle1,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(height * 0.05),
          Text(
            'You are Paying',
            style: TextStyle(fontSize: 16),
          ),
          Gap(height * 0.01),
          SizedBox(
            width: width * 0.5,
            child: TextField(
              // initialValue: amount.toString(),
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                // disabledBorder: InputBorder.none,
                // enabledBorder: InputBorder.none,
                // focusedBorder: InputBorder.none,
                prefixIcon: Icon(
                  Icons.currency_rupee,
                  color: Colors.deepPurple,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12)),
                hintText: 'Enter the amount',
                filled: true,
                fillColor: Color.fromARGB(255, 239, 222, 241),
              ),
              onChanged: (value) {
                setState(() {
                  amount = int.parse(value);
                });
              },
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.only(right: width * 0.01, left: width * 0.01),
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 112, 56, 209),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  amountController.clear();
                  FocusScope.of(context).unfocus();
                  var options = {
                    'key': 'rzp_test_CblvpHIuQvZbuJ',
                    'amount': amount * 100, //in the smallest currency sub-unit.
                    'name': 'Ticketing Infinity Corporation',
                    // Generate order_id using Orders API
                    'description': 'Flight ticket booking platform.',
                    'timeout': 300, // in seconds
                    'prefill': {
                      'contact': '7000427287',
                      'email': 'test@gmail.com'
                      // 'email': FutureBuilder(
                      //   builder: (context, snapshot) {
                      //     var doc = snapshot.data!.docs.firstWhere(
                      //         (element) => element.id == currentUserId);
                      //     return doc['email'];
                      //   },
                      //   future:
                      //       FirebaseFirestore.instance.collection('users').get(),
                      // )
                    }
                  };
                  if (amount >= 1) {
                    _razorpay.open(options);
                  }
                  print(options['amount']);
                  print(options['name']);
                },
                child: Text(
                  'Pay',
                  style: TextStyle(fontSize: 16),
                )),
          )
        ],
      ),
    );
  }
}
