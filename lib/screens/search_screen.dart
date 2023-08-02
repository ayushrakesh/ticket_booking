import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ticket_booking/widgets/tickets_details.dart';

import '../utils/app_styles.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: width * 0.04),
        children: [
          Gap(height * 0.06),
          Text(
            'Book Airline tickets from a wide choice of Airlines',
            textAlign: TextAlign.left,
            style: Styles.headLineStyle1.copyWith(
              fontSize: width * 0.083,
              // fontSize: 35,
            ),
          ),
          Gap(height * 0.05),
          Gap(height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: Colors.grey.shade200,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.030, vertical: width * 0.030),
                height: height * 0.6,
                width: width * 0.48,
                child: Column(
                  children: [
                    Container(
                      height: height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/sit.jpg'),
                          filterQuality: FilterQuality.low,
                        ),
                      ),
                    ),
                    Gap(height * 0.02),
                    Text(
                      '20% discount on the early booking of this flight. Don\'t miss out this chance',
                      style: Styles.headLineStyle2,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: height * 0.3,
                        width: width * 0.4,
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.030,
                          vertical: width * 0.030,
                        ),
                        decoration: BoxDecoration(
                            color: const Color(0xFF3AB8b8),
                            borderRadius: BorderRadius.circular(18)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Discount\nfor survey',
                              style: Styles.headLineStyle2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Gap(height * 0.02),
                            Text(
                              'Take the survey about our services and get discount',
                              style: Styles.headLineStyle2.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: -35,
                        top: -35,
                        child: Container(
                          padding: EdgeInsets.all(width * 0.06),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 18,
                              color: const Color(0xFF189999),
                            ),
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(height * 0.02),
                  Container(
                    height: height * 0.28,
                    width: width * 0.4,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.030, vertical: width * 0.030),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFEc6545),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Take love',
                          textAlign: TextAlign.center,
                          style: Styles.headLineStyle2.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(height * 0.02),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '😍',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              TextSpan(
                                text: '🥰',
                                style: TextStyle(
                                  fontSize: 36,
                                ),
                              ),
                              TextSpan(
                                text: '😘',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
