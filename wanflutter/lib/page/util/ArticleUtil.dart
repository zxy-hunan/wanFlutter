import 'package:flutter/material.dart';
import 'package:wanFlutter/page/entity/article_entity.dart';

import '../ArticleInfoPage.dart';

class ArticleUtil {
  static Widget getRow(
      int index, BuildContext context, List<ArticleDataData> articleList) {
    if (articleList.length <= 0) {
      return Container();
    }
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListTile(
          leading: IconButton(
            icon: articleList[index].collect
                ? Icon(Icons.favorite, color: Theme.of(context).primaryColor)
                : Icon(Icons.favorite_border),
            tooltip: '收藏',
            onPressed: () {
              //收藏或去除收藏
            },
          ),
          title: Text(
            articleList[index].title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    articleList[index].superChapterName,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(articleList[index].author))
              ],
            ),
          ),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
      onTap: () {
        //跳转
        /*     Navigator.push(context,
            builder: (context) => ArticleInfoPage(
                title: articleList[index].title, url: articleList[index].link));*/

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ArticleInfoPage(
              title: articleList[index].title, url: articleList[index].link);
        }));
      },
    );
  }
}
