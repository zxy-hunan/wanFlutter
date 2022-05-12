import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wanFlutter/page/common/Api.dart';
import 'package:wanFlutter/page/entity/CategGroy_entity.dart';
import 'package:wanFlutter/page/http/NetWorkUtil.dart';

import 'CategoryInfoPage.dart';

class CateGoryPage extends StatefulWidget {
  const CateGoryPage({Key? key}) : super(key: key);

  @override
  State<CateGoryPage> createState() => _CateGoryPageState();
}

class _CateGoryPageState extends State<CateGoryPage> {
  List<CateGroyData> _datas = [];
  ScrollController _scrollController = ScrollController();
  int _panelIndex = 0;
  List<IconData> _icons = [
    Icons.star_border,
    Icons.child_care,
    Icons.cloud_queue,
    Icons.ac_unit,
    Icons.lightbulb_outline,
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //最底部
      }
    });
    request();
  }

  void request() async {
    try {
      var response = await NetWorkUtil().get(Api.TREE);
      var map = json.decode(response.toString());
      var cateEntity = CateGroyEntity.fromJson(map);

      for (int i = 0; i < cateEntity.data!.length; i++) {
        cateEntity.data![i].isExpanded = false;
      }

      setState(() {
        _datas = cateEntity.data!;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        displacement: 40,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ExpansionPanelList(
            animationDuration: Duration(milliseconds: 500),
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _panelIndex = panelIndex;
                _datas[panelIndex].isExpanded = !isExpanded;
              });
            },
            children: _datas.map<ExpansionPanel>((CateGroyData cateGroyData) {
              return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      cateGroyData.name!,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    leading: Icon(_icons[Random().nextInt(_icons.length)]),
                  );
                },
                body: Container(
                  height: 200,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: ListView.builder(
                      itemCount: cateGroyData.children!.length,
                      itemBuilder: (BuildContext context, int position) {
                        return getRow(position, cateGroyData);
                      }),
                ),
                isExpanded: cateGroyData.isExpanded!,
              );
            }).toList(),
          ),
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            //刷新
          });
        },
      ),
    );
  }

  Widget getRow(int index, CateGroyData cateGroyData) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: ListTile(
          title: Text(
            cateGroyData.children![index].name!,
            style: TextStyle(color: Colors.black),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
        ),
      ),
      onTap: () {
        //跳转
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategroyInfoPage(panelIndex: _panelIndex, index: index,datas: _datas)));
      },
    );
  }
}
