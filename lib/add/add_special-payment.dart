import 'package:flutter/material.dart';
import 'package:creeasy/main.dart';

class AddSpecialPaymentPage extends StatefulWidget {
  @override
  _AddSpecialPaymentPageState createState() => _AddSpecialPaymentPageState();
}


class _AddSpecialPaymentPageState extends State<AddSpecialPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.account_balance,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              '臨時支払いを追加',
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ))
        ],
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),),
    );
  }
}