import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../utils/app_styles.dart';

class Hotel extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const Hotel(this.hotel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    return Container(
      width: width * 0.54,
      height: height * 0.51,
      margin: EdgeInsets.only(left: width * 0.04),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.036, vertical: width * 0.036),
      decoration: BoxDecoration(
        color: Styles.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 20,
            spreadRadius: 10,
          )
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.26,
            width: width * 0.46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Styles.primaryColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/${hotel['image']}',
                ),
              ),
            ),
          ),
          const Gap(10),
          Text(
            hotel['place'],
            style: Styles.headLineStyle2.copyWith(color: Styles.kakiColor),
          ),
          const Gap(5),
          Text(
            hotel['destination'],
            style: Styles.headLineStyle3.copyWith(color: Colors.white),
          ),
          const Gap(8),
          Text(
            '\$${hotel['price'].toString()}/night',
            style: Styles.headLineStyle1.copyWith(color: Styles.kakiColor),
          ),
        ],
      ),
    );
  }
}
