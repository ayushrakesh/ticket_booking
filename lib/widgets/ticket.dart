import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../utils/app_styles.dart';
import '../widgets/dash_line.dart';
import '../widgets/rounded_container.dart';

class Ticket extends StatelessWidget {
  final Map<String, dynamic> ticket;
  final bool isColor;

  const Ticket(this.ticket, {Key? key, this.isColor = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;

    return Container(
      padding: isColor == false ? EdgeInsets.only(left: width * 0.04) : null,
      width: width * 0.77,
      child: Column(
        children: [
          // Blue part of the ticket
          Container(
            height: height * 0.11,
            decoration: BoxDecoration(
              color: isColor == false ? const Color(0xFF526799) : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(21),
                topRight: Radius.circular(21),
              ),
            ),
            padding: const EdgeInsets.all(
              16,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      ticket['from-code'],
                      style: isColor == false
                          ? Styles.headLineStyle3.copyWith(color: Colors.white)
                          : Styles.headLineStyle3,
                    ),
                    const Spacer(),
                    const RoundedContainer(true),
                    Expanded(
                      child: Stack(
                        children: [
                          const SizedBox(
                            height: 24,
                            child: DashLines(true, 6, 3),
                          ),
                          Center(
                            child: Transform.rotate(
                              angle: 1.5,
                              child: Icon(
                                Icons.local_airport_rounded,
                                color: isColor == false
                                    ? Colors.white
                                    : const Color(0xFF8ACCf7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const RoundedContainer(true),
                    const Spacer(),
                    Text(
                      ticket['to-code'],
                      style: isColor == false
                          ? Styles.headLineStyle3.copyWith(color: Colors.white)
                          : Styles.headLineStyle3,
                    ),
                  ],
                ),
                const Gap(3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        ticket['from-code'],
                        style: isColor == false
                            ? Styles.headLineStyle4
                                .copyWith(color: Colors.white)
                            : Styles.headLineStyle4,
                      ),
                    ),
                    Text(
                      ticket['flying-time'],
                      style: isColor == false
                          ? Styles.headLineStyle4.copyWith(color: Colors.white)
                          : Styles.headLineStyle4,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        ticket['to-name'],
                        textAlign: TextAlign.end,
                        style: isColor == false
                            ? Styles.headLineStyle4
                                .copyWith(color: Colors.white)
                            : Styles.headLineStyle4,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Orange part of the ticket
          Container(
            height: height * 0.032,
            color: isColor == false ? Styles.orangeColor : Colors.white,
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isColor == false
                          ? Colors.grey.shade200
                          : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: DashLines(true, 8, 5)),
                ),
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isColor == false
                          ? Colors.grey.shade200
                          : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.11,
            decoration: BoxDecoration(
              color: isColor == false ? Styles.orangeColor : Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: isColor == false
                    ? const Radius.circular(21)
                    : const Radius.circular(0),
                bottomRight: isColor == false
                    ? const Radius.circular(21)
                    : const Radius.circular(0),
              ),
            ),
            padding: const EdgeInsets.all(
              16,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket['date'],
                          style: isColor == false
                              ? Styles.headLineStyle3
                                  .copyWith(color: Colors.white)
                              : Styles.headLineStyle3,
                        ),
                        const Gap(5),
                        Text('DATE',
                            style: isColor == false
                                ? Styles.headLineStyle4
                                    .copyWith(color: Colors.white)
                                : Styles.headLineStyle4),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ticket['departure-time'],
                          style: isColor == false
                              ? Styles.headLineStyle3
                                  .copyWith(color: Colors.white)
                              : Styles.headLineStyle3,
                        ),
                        const Gap(5),
                        Text(
                          'Departure time',
                          style: isColor == false
                              ? Styles.headLineStyle4
                                  .copyWith(color: Colors.white)
                              : Styles.headLineStyle4,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ticket['number'].toString(),
                          style: isColor == false
                              ? Styles.headLineStyle3
                                  .copyWith(color: Colors.white)
                              : Styles.headLineStyle3,
                        ),
                        const Gap(5),
                        Text(
                          'Number',
                          style: isColor == false
                              ? Styles.headLineStyle4
                                  .copyWith(color: Colors.white)
                              : Styles.headLineStyle4,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
