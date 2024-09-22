import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:creeasy/5tab_folders/home/home.dart';
import 'package:creeasy/5tab_folders/card_manage/card_manage.dart';
import 'package:creeasy/5tab_folders/add/add_payment.dart';
import 'package:creeasy/5tab_folders/add/add_special-payment.dart';
import 'package:creeasy/5tab_folders/add/add_use-point.dart';
import 'package:creeasy/5tab_folders/status/status.dart';
import 'package:creeasy/5tab_folders/money_manage/money_manage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';


void main() {
  runApp(const StartPageHome());
}

class StartPageHome extends StatelessWidget {
  const StartPageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartPageWidget(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ja"),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0A0E21),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xfff0f0f0),
        ),
        // fontFamily: 'IBM_Plex_Sans_JP',
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xfff0f0f0),
        ),
        fontFamily: 'MPlus1p',
      ),
    );
  }
}

class StartPageWidget extends StatefulWidget {
  const StartPageWidget({super.key});

  @override
  State<StartPageWidget> createState() => _StartPageWidgetState();
}

class _StartPageWidgetState extends State<StartPageWidget> {
  // const _StartPageWidgetState({Key? key}) : super(key: key);
  var _currentIndex = 0;
  final _pages = <Widget>[
    const HomePage(),
    const CardManagePage(),
    const AddPaymentPage(),
    const MoneyManagePage(),
    const StatusPage()
  ];

  void _onTap(int index) {
    if (index == 2) {
      // "追加" ボタンが押されたとき
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
        title: const Text(
          '追加する項目を選択：',
          style: TextStyle(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.credit_score_outlined, size: addButtonItemIconSize()),
                addButtonItemBetweenIconText(),
                Text('利用履歴', style: addButtonItemTextStyle()),
              ],
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPaymentPage(),
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
                Icon(Icons.account_balance, size: addButtonItemIconSize()),
                addButtonItemBetweenIconText(),
                Text('臨時支払い', style: addButtonItemTextStyle()),
              ],
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddSpecialPaymentPage(),
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
                Icon(Icons.stars_outlined, size: addButtonItemIconSize()),
                addButtonItemBetweenIconText(),
                Text('ポイント割当', style: addButtonItemTextStyle()),
              ],
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddUsePointPage(),
                  fullscreenDialog: true,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('キャンセル'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_currentIndex == 0) ? Colors.black : Colors.black26,
              size: (_currentIndex == 0) ? selectedTabIconSize() : unselectedTabIconSize(),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.wallet_outlined,
              color: (_currentIndex == 1) ? Colors.black : Colors.black26,
              size: (_currentIndex == 1) ? selectedTabIconSize() : unselectedTabIconSize(),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_outlined,
              color: (_currentIndex == 2) ? Colors.black : Colors.black26,
              size: (_currentIndex == 2) ? selectedTabIconSize() : unselectedTabIconSize(),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task_alt_outlined,
              color: (_currentIndex == 3) ? Colors.black : Colors.black26,
              size: (_currentIndex == 3) ? selectedTabIconSize() : unselectedTabIconSize(),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_walk_outlined,
              color: (_currentIndex == 4) ? Colors.black : Colors.black26,
              size: (_currentIndex == 4) ? selectedTabIconSize() : unselectedTabIconSize(),
            ),
            label: '',
          ),
        ],
        currentIndex: _currentIndex, // 現在のインデックスを設定
        onTap: _onTap, // タップ時に呼ばれるメソッドを設定
        unselectedIconTheme:
            const IconThemeData(size: 25, color: Colors.black54),
        selectedIconTheme: const IconThemeData(color: Colors.black),
        // showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// addボタンを押した後の項目のテキスト部分のTextStyle
TextStyle addButtonItemTextStyle() {
  return const TextStyle(
    fontSize: 19,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
}

// addボタンを押した後の項目のアイコンのサイズ
double addButtonItemIconSize() {
  return 24;
}

// addボタンを押した後の項目のアイコンとテキストの間隔
SizedBox addButtonItemBetweenIconText() {
  return const SizedBox(width: 12);
}

double selectedTabIconSize() {
  return 30;
}

double unselectedTabIconSize() {
  return 24;
}
