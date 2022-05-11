import 'package:flutter/material.dart';

import 'LoginPage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 30),
          Container(child: Image.asset('images/ic_icon.png')),
          SizedBox(height: 30),
          ListTile(
              leading: Icon(Icons.favorite_border),
              title: Text("我的收藏"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {}),
          ListTile(
              leading: Icon(Icons.share),
              title: Text("分享"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {}),
          ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("关于"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {}),
          ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("登录"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return LoginPage();
                }));
              })
        ],
      ),
    );
  }
}
