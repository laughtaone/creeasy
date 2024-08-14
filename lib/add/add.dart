import 'package:flutter/material.dart';
import 'package:creeasy/main.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}


class _AddPageState extends State<AddPage> {
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
              Icons.add_outlined,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              '追加',
            ),
          ],
        ),
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),),
    );
  }
}