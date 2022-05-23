import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wanFlutter/page/common/Api.dart';
import 'package:wanFlutter/page/entity/Nav_entity.dart';
import 'package:wanFlutter/page/entity/article_entity.dart';
import 'package:wanFlutter/page/http/NetWorkUtil.dart';

import 'ArticleInfoPage.dart';

/**
 * 导航
 */
class NavItem1 extends StatefulWidget {
  const NavItem1({Key? key}) : super(key: key);

  @override
  State<NavItem1> createState() => _NavItem1State();
}

class _NavItem1State extends State<NavItem1> {
  List<NaviData> _datas = []; //一级分类
  List<ArticleDataData> articles = []; //二级分类
  int currentIndex = 0; //一级分类下标

  @override
  void initState() {
    super.initState();
    request();
  }

  void request() async {
    try {
      var response = await NetWorkUtil().get(Api.NAVI);
      var naviEntity = NaviEntity.fromJson(json.decode(response.toString()));
      setState(() {
        _datas = naviEntity.data!;
        currentIndex = 0;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: _datas.length,
                itemBuilder: (BuildContext context, int index) {
                  //一级下标的内容
                  return getNavView(index);
                },
              ),
            )),
        Expanded(
            flex: 5,
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  //一级下标写的子内容
                  child: getNavChildView(currentIndex),
                )
              ],
            )),
      ],
    );
  }

  /**
   * 一级标题内容
   */
  Widget getNavView(int index) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding:
            EdgeInsets.symmetric(vertical: 15, horizontal: 10), //左右间隔10，上下间隔15
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.grey : Colors.white,
            border: Border(
                left: BorderSide(
                    width: 5,
                    color: currentIndex == index
                        ? Theme.of(context).primaryColor
                        : Colors.white))),
        child: Text(
          _datas[index].name!,
          style: TextStyle(
            color: currentIndex == index
                ? Theme.of(context).primaryColor
                : Colors.blue,
            fontWeight:
                currentIndex == index ? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }

  getNavChildView(index) {
    _updateArticles(index);
    return Wrap(
      spacing: 10,
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      children: List.generate(articles.length, (int index) {
        return ActionChip(
            label: Text(articles[index].title,
                style: TextStyle(fontSize: 16, color: Colors.white)),
            onPressed: () {
              //跳转
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ArticleInfoPage(
                    title: articles[index].title, url: articles[index].link);
              }));
            },
            elevation: 3,
            backgroundColor: Colors.blue);
      }).toList(),
    );
  }

  List<ArticleDataData> _updateArticles(int index) {
    setState(() {
      if (_datas.length != 0) articles = _datas[index].articles!;
    });
    return articles;
  }
}
