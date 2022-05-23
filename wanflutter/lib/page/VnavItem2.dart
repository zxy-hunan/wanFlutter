import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanFlutter/page/common/Api.dart';
import 'package:wanFlutter/page/entity/project_entity.dart';
import 'package:wanFlutter/page/entity/project_list_entity.dart';
import 'package:wanFlutter/page/http/NetWorkUtil.dart';

import 'ArticleInfoPage.dart';

/**
 * 项目
 */
class NavItem2 extends StatefulWidget {
  const NavItem2({Key? key}) : super(key: key);

  @override
  State<NavItem2> createState() => _NavItem1State();
}

class _NavItem1State extends State<NavItem2> with TickerProviderStateMixin {
  late TabController _controller;
  int _currentIndex = 0;

  List<ProjectData> _datas = [];
  List<ProjectListDataData> _listDatas = [];

  int _page = 1;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 0, vsync: this);
    request();
  }

  Future request() async {
    var response = await NetWorkUtil().get(Api.PROJECT);
    var projectEntity =
        ProjectEntity.fromJson(json.decode(response.toString()));
    setState(() {
      _datas = projectEntity.data!;
      _controller = TabController(length: _datas.length, vsync: this);
    });
    getDetail();
    _controller.addListener(_onTabChanged);
  }

  _onTabChanged() {
    if (_controller.index.toDouble() == _controller.animation!.value) {
      setState(() {
        _currentIndex = _controller.index;
      });
      getDetail();
    }
  }

  void getDetail() async {
    try {
      var data = {"cid": _datas[_currentIndex].id};
      var response =
          await NetWorkUtil().get(Api.PROJECT_LIST + "$_page/json", data: data);
      var projectListEntity =
          ProjectListEntity.fromJson(json.decode(response.toString()));
      setState(() {
        _listDatas = projectListEntity.data!.datas!;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
          labelColor: Theme.of(context).primaryColor,
          labelStyle: TextStyle(fontSize: 16),
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: TextStyle(fontSize: 14),
          indicatorColor: Theme.of(context).primaryColor,
          isScrollable: true,
          tabs: _datas.map((ProjectData projectData) {
            return Tab(text: projectData.name);
          }).toList(),
          onTap: (int index) {},
          controller: _controller),
      body: TabBarView(
        controller: _controller,
        children: _datas.map((ProjectData projectData) {
          return EasyRefresh.custom(
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return getRow(index);
              }, childCount: _listDatas.length)),
            ],
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  _page = 1;
                });
                getDetail();
              });
            },
            onLoad: () async {
              await Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  _page++;
                });
                // loadMore();
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget getRow(int index) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Image.network(_listDatas[index].envelopePic!)),
                Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _listDatas[index].title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            _listDatas[index].desc,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      _listDatas[index].niceDate,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  _listDatas[index].author,
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.right,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ArticleInfoPage(
              title: _listDatas[index].title, url: _listDatas[index].link);
        }));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
