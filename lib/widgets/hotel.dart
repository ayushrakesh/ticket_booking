import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

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
            height: height * 0.20,
            width: width * 0.46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Styles.primaryColor,
              // image: DecorationImage(
              //     fit: BoxFit.cover,
              //     image: NetworkImage(
              //       '${hotel['image']}',
              //     )),
            ),
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                  placeholder: 'assets/gifs/loading.gif',
                  image: hotel['image'],
                ),
              ),
            ),
          ),
          Gap(height * 0.01),
          Text(
            hotel['place'],
            style: Styles.headLineStyle2.copyWith(color: Styles.kakiColor),
          ),
          Gap(height * 0.01),
          Text(
            hotel['destination'],
            style: Styles.headLineStyle3.copyWith(color: Colors.white),
          ),
          Gap(height * 0.005),
          Text(
            '\$${hotel['price'].toString()}/night',
            style: Styles.headLineStyle1.copyWith(
              color: Styles.kakiColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
