import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:creeasy/home/home.dart';
import 'package:creeasy/cart_manage/card_manage.dart';
import 'package:creeasy/add/add_payment.dart';
import 'package:creeasy/add/add_special-payment.dart';
import 'package:creeasy/add/add_use-point.dart';
import 'package:creeasy/calender/calender.dart';
import 'package:creeasy/settings/settings.dart';
import 'package:flutter/cupertino.dart';


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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en"),
        const Locale("ja"),
      ],
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
        fontFamily: 'MPlus1p',
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
    AddPaymentPage(),
    CalenderPage(),
    SettingsPage()
  ];

  void _onTap(int index) {
    if (index == 2) { // "追加" ボタンが押されたとき
      _showCupertinoActionSheet(context);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _showCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text('追加する項目を選択：'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.credit_score_outlined, size: 20),
                SizedBox(width: 5),
                Text('利用履歴を追加'),
              ],
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPaymentPage(),
                  fullscreenDialog: true,
                ),
              );
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_balance, size: 20),
                SizedBox(width: 5),
                Text('臨時支払いを追加'),
              ],
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSpecialPaymentPage(),
                  fullscreenDialog: true,
                ),
              );
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.stars_outlined, size: 20),
                SizedBox(width: 5),
                Text('ポイント割当を追加'),
              ],
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUsePointPage(),
                  fullscreenDialog: true,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('キャンセル'),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
        currentIndex: _currentIndex, // 現在のインデックスを設定
        onTap: _onTap, // タップ時に呼ばれるメソッドを設定
        unselectedIconTheme: const IconThemeData(size: 25, color: Colors.black54),
        selectedIconTheme: const IconThemeData(color: Colors.black),
        // showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
