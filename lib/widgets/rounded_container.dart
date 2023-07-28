import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final bool isColor;

  const RoundedContainer(this.isColor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2.5,
          // ignore: unnecessary_null_comparison
          color: isColor == null ? Colors.white : const Color(0xFF8accf7),
        ),
      ),
    );
  }
}
