import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_styles.dart';

class BarCode extends StatelessWidget {
  final height = Get.height;

  BarCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarcodeWidget(
      barcode: Barcode.code128(),
      data: 'https://github.com/ayushrakesh',
      height: height * 0.07,
      width: double.infinity,
      drawText: false,
      color: Styles.textColor,
    );
  }
}
