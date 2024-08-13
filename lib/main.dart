import 'package:flutter/material.dart';
import 'package:creeasy/home/home.dart';
import 'package:creeasy/cart_manage/card_manage.dart';
import 'package:creeasy/add/add.dart';
import 'package:creeasy/calender/calender.dart';
import 'package:creeasy/settings/settings.dart';



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
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF0A0E21),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xfff0f0f0),
        ),
        // fontFamily: 'IBM_Plex_Sans_JP',
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xfff0f0f0),
        ),
      ),
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
  var _currentIndex = 0;
  var _pages = <Widget>[
    HomePage(),
    CardManagePage(),
    AddPage(),
    CalenderPage(),
    SettingsPage()

  ];
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'カード管理',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined),
            label: '追加',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined),
            label: 'カレンダー',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
        currentIndex: _currentIndex, // 現在のインデックスを設定
        onTap: _onTap, // タップ時に呼ばれるメソッドを設定
        unselectedIconTheme: const IconThemeData(size: 25, color: Colors.black54),
        selectedIconTheme: const IconThemeData(color: Colors.black),
      ),
    );
  }
}
