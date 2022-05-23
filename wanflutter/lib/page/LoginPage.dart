import 'package:flutter/material.dart';
import 'package:wanFlutter/page/widget/EditText.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("登录"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(child: Image.asset('images/ic_icon.png')),
              SizedBox(height: 40),
              EditText(hintText: "用户名"),
              EditText(hintText: "密码"),
              Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text(
                    "去注册",
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                  alignment: Alignment(1, 0)),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  width: double.infinity,
                  child: OutlinedButton(onPressed: () {}, child: Text("确定")))
            ],
          ),
        ),
      ),
    );
  }
}
