import 'package:flutter/material.dart';
import 'package:creeasy/common_component.dart';

class ChangeBankPage extends StatefulWidget {
  @override
  _ChangeBankPageState createState() => _ChangeBankPageState();
}


class _ChangeBankPageState extends State<ChangeBankPage> {
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
              Icons.assured_workload_outlined,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              '銀行情報を変更',
            ),
          ],
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
        actions: [ToprightCloseButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      ),
    );
  }
}