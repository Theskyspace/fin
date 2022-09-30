import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TXN_BLOCK extends StatelessWidget {
  TXN_BLOCK(this.title, this.amount, {Key? key}) : super(key: key);
  String title;
  int amount;
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
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          const Spacer(
            flex: 1,
          ),
          Text("₹ $amount", style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}
