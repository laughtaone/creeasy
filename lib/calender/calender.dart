import 'package:flutter/material.dart';
import 'package:creeasy/main.dart';

class CalenderPage extends StatefulWidget {
  @override
  _CalenderPageState createState() => _CalenderPageState();
}


class _CalenderPageState extends State<CalenderPage> {
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
              Icons.date_range_outlined,
              color: Colors.black
            ),
            SizedBox(width: 5),
            Text(
              'カレンダー',
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