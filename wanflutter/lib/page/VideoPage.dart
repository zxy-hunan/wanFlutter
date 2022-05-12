import 'package:flutter/material.dart';
import 'package:wanFlutter/page/VnavItem1.dart';

import 'VnavItem2.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<Widget> children = [NavItem1(), NavItem2()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blue,
            title: Row(
              children: [
                Expanded(
                    child: TabBar(
                  tabs: [Tab(text: '导航'), Tab(text: '项目')],
                ))
              ],
            ),
          ),
          body: TabBarView(
            children: children,
          ),
        ));
  }
}
