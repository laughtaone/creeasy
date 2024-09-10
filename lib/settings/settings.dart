import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final String mySnsId = '@******';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.settings, color: Colors.black),
            SizedBox(width: 5),
            Text(
              '設定',
            ),
          ],
        ),
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 20),
              icon: const Icon(Icons.close, size: 27),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        sections: [
          SettingsSection(
            title: Text('使い方', style: settingSectionTitleTextSyle()),
            tiles: [
              SettingsTile.navigation(
                leading: const Icon(Icons.language_outlined),
                title:
                    Text('公式解説サイト', style: settingSectionTilesTitleTextSyle()),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.table_rows_outlined),
                title: Text('Googleスプレッドシート版',
                    style: settingSectionTilesTitleTextSyle()),
              )
            ],
          ),
          SettingsSection(
            title: Text('開発者について', style: settingSectionTitleTextSyle()),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const FaIcon(FontAwesomeIcons.xTwitter),
                title: Text('X', style: settingSectionTilesTitleTextSyle()),
                value: Text(mySnsId),
                onPressed: (BuildContext context) {
                  _launchX();
                },
              ),
              SettingsTile.navigation(
                leading: const FaIcon(FontAwesomeIcons.tiktok),
                title:
                    Text('TikTok', style: settingSectionTilesTitleTextSyle()),
                value:  Text(mySnsId),
                onPressed: (BuildContext context) {
                  _launchTikTok();
                },
              ),
              SettingsTile.navigation(
                leading: const FaIcon(FontAwesomeIcons.youtube),
                title:
                    Text('YouTube', style: settingSectionTilesTitleTextSyle()),
                value: Text(mySnsId),
                onPressed: (BuildContext context) {
                  _launchYouTube();
                },
              ),
              SettingsTile.navigation(
                leading: const FaIcon(FontAwesomeIcons.instagram),
                title: Text('Instagram',
                    style: settingSectionTilesTitleTextSyle()),
                value: Text(mySnsId),
                onPressed: (BuildContext context) {
                  _launchInstagram();
                },
              ),
              SettingsTile.navigation(
                leading: const FaIcon(FontAwesomeIcons.github),
                title:
                    Text('GitHub', style: settingSectionTilesTitleTextSyle()),
                value: Text(mySnsId),
                onPressed: (BuildContext context) {
                  _launchGitHub();
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('アプリについて', style: settingSectionTitleTextSyle()),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.description_outlined),
                title: Text('利用規約', style: settingSectionTilesTitleTextSyle()),
                onPressed: (BuildContext context) {
                  _launchTerms();
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.book_outlined),
                title: Text('プライバシーポリシー',
                    style: settingSectionTilesTitleTextSyle()),
                onPressed: (BuildContext context) {
                  _launchPrivacyPolcy();
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.book_outlined),
                title:
                    Text('使用ドキュメント', style: settingSectionTilesTitleTextSyle()),
                onPressed: (BuildContext context) {
                  _launchPrivacyPolcy();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

TextStyle settingSectionTitleTextSyle() {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

TextStyle settingSectionTilesTitleTextSyle() {
  return const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
}

Future _launchX() async {
  final url = Uri.parse('https://www.x.com/');
  launchUrl(url);
}

Future _launchTikTok() async {
  final url = Uri.parse('https://www.tiktok.com/');
  launchUrl(url);
}

Future _launchYouTube() async {
  final url = Uri.parse('https://www.youtube.com/');
  launchUrl(url);
}

Future _launchGitHub() async {
  final url = Uri.parse('https://www.github.com/');
  launchUrl(url);
}

Future _launchInstagram() async {
  final url = Uri.parse('https://www.instagram.com/');
  launchUrl(url);
}

Future _launchTerms() async {
  final url = Uri.parse(
      'https://www.google.com');
  launchUrl(url);
}

Future _launchPrivacyPolcy() async {
  final url = Uri.parse(
      'https://www.google.com');
  launchUrl(url);
}
