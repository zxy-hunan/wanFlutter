import 'package:flutter/material.dart';
import 'package:wanFlutter/page/Category.dart';
import 'package:wanFlutter/page/HomePage.dart';
import 'package:wanFlutter/page/SettingPage.dart';
import 'package:wanFlutter/page/VideoPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List _pageList = [HomePage(), CateGoryPage(), VideoPage(), SettingPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("wanFlutter"), elevation: 0 //去除底部阴影
            ),
        body: this._pageList[this._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 20,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: this._currentIndex,
          onTap: (int index) {
            setState(() {
              this._currentIndex = index;
            });
            print(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "设置"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "我")
          ],
        ),
      ),
    );
  }
}
