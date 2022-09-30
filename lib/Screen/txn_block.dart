import 'dart:math';
import 'package:flutter/material.dart';

class TxnBlock extends StatelessWidget {
  TxnBlock(this.title, this.amount, {Key? key}) : super(key: key);
  final String title;
  final int amount;

  List colorList = [
    Colors.amber[200],
    Colors.green[200],
    Colors.blue[200],
    Colors.purple[200],
    Colors.red[200],
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: colorList[Random().nextInt(colorList.length)],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(
            flex: 1,
          ),
          Text("₹ $amount",
              style: const TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 118, 8, 1)))
        ],
      ),
    );
  }
}
