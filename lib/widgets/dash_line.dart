import 'package:flutter/material.dart';

class DashLines extends StatelessWidget {
  final bool isColor;
  final int sections;
  final double width;

  const DashLines(this.isColor, this.sections, this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          (constraints.constrainWidth() / sections).floor(),
          (index) => SizedBox(
            width: width,
            height: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isColor == false ? Colors.white : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
