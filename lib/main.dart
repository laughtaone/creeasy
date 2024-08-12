import 'package:flutter/material.dart';


void main() {
  runApp(
    StartPageHome()
  );
}

class StartPageHome extends StatelessWidget {
  const StartPageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartPageWidget(),
    );
  }
}

class StartPageWidget extends StatefulWidget {
  const StartPageWidget({Key? key}) : super(key: key);

  @override
  State<StartPageWidget> createState() => _StartPageWidgetState();
}


class _StartPageWidgetState extends State<StartPageWidget> {
  // const _StartPageWidgetState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: Text('ホーム'),),
        body: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Text('こんにちは！'),
            Text('今月の使用状況')
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card, color: Colors.black),
              label: 'カード管理',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline, color: Colors.black),
              label: '追加',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.date_range, color: Colors.black),
              label: 'カレンダー',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.black),
              label: '設定',
            ),
          ],
        ),
      ),
    );
  }
}