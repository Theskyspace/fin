import 'dart:developer';

import 'package:fin/Screen/QRScreen.dart';
import 'package:fin/Screen/txn_block.dart';
import 'package:fin/helper/database_helper.dart';
import 'package:fin/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Database db;
  late Future<List<Map<String, dynamic>>?> transactions;

  @override
  void initState() {
    // TODO: implement initState
    transactions = DatabaseHelper.instance.queryAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.13,
        backgroundColor: CustomColors.primaryBackground,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: CustomColors.primaryBackground,
        ),
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            color: CustomColors.primaryBackground,
            margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Namaste",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "Akash Joshi",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.white,
                      size: 30,
                    )),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: height * .30,
              child: Stack(
                children: [
                  Container(
                    height: height * 0.18,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryBackground,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 100.0)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 15),
                      height: height * .23,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: CustomColors.secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 15,
                              color: Color.fromARGB(100, 0, 0, 0),
                              offset: Offset(2, 2),
                              spreadRadius: 1,
                            )
                          ]),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Fun Money Balance",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "₹ 500.00",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Income",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "₹ 1,840.00",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "Expenses",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "₹ 284.00",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Transaction History",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 200,
                    child: FutureBuilder<List<Map<String, dynamic>>?>(
                        future: transactions,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  return TXN_BLOCK(
                                      snapshot.data![index]["title"],
                                      snapshot.data![index]["amount"]);
                                });
                          } else {
                            return const Text("hello");
                          }
                        }),
                  )
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            FloatingActionButton(
                heroTag: "btnQR",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QRexample(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
