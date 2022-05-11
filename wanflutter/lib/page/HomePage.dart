// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanFlutter/page/common/Api.dart';
import 'package:wanFlutter/page/entity/BannerEntity.dart';
import 'package:wanFlutter/page/http/NetWorkUtil.dart';

/**
 * 首页
 */

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerData> bannerList = [];
  late SwiperController _swiperControl;

  @override
  void initState() {
    super.initState();
    _swiperControl = new SwiperController();
    request();
  }

  void request() async {
    try {
      var bannerResponse = await NetWorkUtil().get(Api.BANNER);
      var bannerEntity =
          BannerEntity.fromJson(json.decode(bannerResponse.toString()));

      setState(() {
        bannerList = bannerEntity.data!;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: EasyRefresh.custom(
          onRefresh: () async {},
          onLoad: () async {},
          slivers: <Widget>[
            SliverList(delegate: SliverChildBuilderDelegate((context, index) {
              if (index == 0) return getBanner();
            }))
          ]),
    );
  }

  Widget getBanner() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 1.8 * 0.8,
      padding: EdgeInsets.all(10),
      child: Swiper(
        itemCount: bannerList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(bannerList[index].imagePath),
                    fit: BoxFit.fill)),
          );
        },
        loop: false,
        autoplayDelay: 3000,
        autoplayDisableOnInteraction: true,
        duration: 600,
        controller: _swiperControl,
        //指示器
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(size: 6, activeSize: 9),
        ),
        viewportFraction: 0.8,
        scale: 0.9,
        onTap: (int index) {
          print("click $index image");
        },
      ),
    );
  }
}
