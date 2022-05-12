import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanFlutter/page/common/Api.dart';
import 'package:wanFlutter/page/entity/CategGroy_entity.dart';
import 'package:wanFlutter/page/entity/article_entity.dart';
import 'package:wanFlutter/page/http/NetWorkUtil.dart';
import 'package:wanFlutter/page/util/ArticleUtil.dart';

/**
 * 分类详细信息
 */
class CategroyInfoPage extends StatefulWidget {
  final int panelIndex; //一级下标
  final int index; //二级下标
  List<CateGroyData> datas = []; //一级分类数据

  CategroyInfoPage(
      {Key? key,
      required this.panelIndex,
      required this.index,
      required this.datas})
      : super(key: key);

  @override
  State<CategroyInfoPage> createState() => _CategroyInfoState();
}

class _CategroyInfoState extends State<CategroyInfoPage>
    with TickerProviderStateMixin {
  late TabController _controller; //tab控制
  int _currentIndex = 0;

  List<CateGroyDataChild> _tabDatas = []; //二级分类
  List<ArticleDataData> _articleDatas = []; //内容集合
  String _title = '';
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    initData();
    _controller.addListener(() {
      _onTabChanged();
    });
    _controller.animateTo(_currentIndex);
    getTabInfo();
  }

  _onTabChanged() {
    if (_controller.index.toDouble() == _controller.animation!.value) {
      setState(() {
        _currentIndex = _controller.index;
      });
      getTabInfo();
    }
  }

  void initData() {
    setState(() {
      _tabDatas = widget.datas[widget.panelIndex].children!;
      _controller = TabController(length: _tabDatas.length, vsync: this);

      _currentIndex = widget.index;
      _title = widget.datas[widget.panelIndex].name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
        bottom: TabBar(
          controller: _controller,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 16),
          unselectedLabelColor: Colors.white,
          unselectedLabelStyle: TextStyle(fontSize: 16),
          indicatorColor: Colors.white,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: _tabDatas.map((CateGroyDataChild child) {
            return Tab(
              text: child.name!,
            );
          }).toList(),
          onTap: (int i) {
            print(i);
          },
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: _tabDatas.map((CateGroyDataChild cateGroyData) {
          return EasyRefresh.custom(
              onRefresh: () async {},
              onLoad: () async {},
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return getRow(index);
                }, childCount: _articleDatas.length)),
              ]);
        }).toList(),
      ),
    );
  }

  Widget getRow(int index) {
    return ArticleUtil.getRow(index, context, _articleDatas);
  }

  /**
   * 获取下标的数据
   */
  Future getTabInfo() async {
    this.setState(() {
      _page = 0;
    });
    var data = {"cid": _tabDatas[_currentIndex].id};
    var response =
        await NetWorkUtil().get(Api.ARTICLE_LIST + "$_page/json", data: data);
    var articleEntity =
        ArticleEntity.fromJson(json.decode(response.toString()));
    if (articleEntity.data!.datas!.length > 0) {
      setState(() {
        _articleDatas = articleEntity.data!.datas!;
      });
    }
  }
}
