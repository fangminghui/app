import 'package:app/pages/login.dart';
import 'package:app/pages/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1080, 1920), allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              padding: EdgeInsets.all(0),
              iconSize: 40,
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: ScreenUtil().setHeight(100),
        title: Text("设置",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          MyBackground(),
          Column(
            children: [MySplit(), MyButton(), MySplit(), MyQuit()],
          ),
        ],
      ),
    );
  }
}

class MyBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
              alignment: Alignment.topRight)),
    );
  }
}

class MySplit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setHeight(120),
      color: Color(0x66ffffff),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(120),
        color: Color(0xffffffff),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(20)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => About()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '关于本软件',
                style: TextStyle(fontSize: ScreenUtil().setSp(48)),
              ),
              Icon(
                Icons.chevron_right,
                color: Color(0xff333333),
                size: 30,
              ),
            ],
          ),
        ));
  }
}

class MyQuit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(120),
        color: Color(0xffffffff),
        alignment: Alignment.center,
        child: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text('退出登录',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(52),
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  )),
            )));
  }
}
