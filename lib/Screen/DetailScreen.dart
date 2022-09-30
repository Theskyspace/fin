import 'dart:developer';
import 'package:fin/helper/database_helper.dart';
import 'package:fin/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class AddDetail extends StatelessWidget {
  AddDetail(this.deepLink, {Key? key}) : super(key: key);
  late String deepLink;
  late String message;
  late String amount = "0";

  @override
  Widget build(BuildContext context) {
    log(deepLink);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 17),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const Text("Akash"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              "You are paying",
              style: TextStyle(fontSize: 15),
            ),
            TextField(
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              autofocus: true,
              onChanged: (value) {
                if (value != "" && value != "0") {
                  amount = value;
                } else {
                  amount = "0";
                }
                log(value.toString());
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '₹ 0',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(25)),
              child: TextField(
                style: const TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                autofocus: true,
                onChanged: (value) {
                  if (value != "") {
                    message = value;
                  }
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add a message',
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: CustomColors.primaryBackground,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () async {
                log(deepLink);
                log(amount);
                if (amount != "0") {
                  int i = await DatabaseHelper.instance.insert({
                    "title": message,
                    "amount": int.parse(amount),
                    "payee": deepLink,
                  });
                  log("$deepLink&am=$amount");
                  launchUrl(Uri.parse("$deepLink&am=$amount&msg=asdas"));
                } else {
                  log("amount is not 0 or ");
                }
              },
              child: const Text(
                'Pay',
                style: TextStyle(fontSize: 20),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
