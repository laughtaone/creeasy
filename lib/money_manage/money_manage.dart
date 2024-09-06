import 'package:flutter/material.dart';
import 'package:creeasy/main.dart';

class MoneyManagePage extends StatefulWidget {
  @override
  _MoneyManagePageState createState() => _MoneyManagePageState();
}


class _MoneyManagePageState extends State<MoneyManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.task_alt_outlined,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              '使用履歴管理',
            ),
          ],
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      ),
    );
  }
}