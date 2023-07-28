import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../utils/app_styles.dart';

class TicketDetails extends StatelessWidget {
  final width = Get.width;
  final height = Get.height;

  final IconData icon;
  final String text;

  TicketDetails(this.icon, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFBFC2DF),
          ),
          Gap(height * 0.02),
          Text(
            text,
            style: Styles.textStyle,
          )
        ],
      ),
    );
  }
}
