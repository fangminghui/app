import 'package:app/pages/monitor/Monitor7.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/pages/monitor/Monitor1.dart';
import 'package:app/pages/monitor/Monitor2.dart';
import 'package:app/pages/monitor/Monitor3.dart';
import 'package:app/pages/monitor/Monitor4.dart';
import 'package:app/pages/monitor/Monitor5.dart';
import 'package:app/pages/monitor/Monitor6.dart';

class Monitor extends StatelessWidget {
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
        backgroundColor: Color(0xfff3f3f3),
        toolbarHeight: ScreenUtil().setHeight(100),
        title: Text("运行监测",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              MyButton(tag: "水位参数"),
              MyButton(tag: "西海水厂"),
              MyButton(tag: "天海水厂"),
              MyButton(tag: "取水站"),
              MyButton(tag: "加压站"),
              MyButton(tag: "温泉水厂"),
              MyButton(tag: "流量统计")
            ],
          ),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton({Key key, this.tag}) : super(key: key);
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
          border: new Border(
            bottom: BorderSide(width: 1, color: Color(0x66000000)),
          ),
          color: Color(0x40ffffff),
        ),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(20)),
        child: InkWell(
          onTap: () {
            Widget page = Monitor();
            switch (tag) {
              case '水位参数':
                {
                  // page = Monitor1();
                }
                break;
              case '西海水厂':
                {
                  // page = Monitor2();
                }
                break;
              case '天海水厂':
                {
                  page = Monitor3();
                }
                break;
              case '取水站':
                {
                  page = Monitor4();
                }
                break;
              case '加压站':
                {
                  page = Monitor5();
                }
                break;
              case '温泉水厂':
                {
                  page = Monitor6();
                }
                break;
              case '流量统计':
                {
                  page = Monitor7();
                }
                break;
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$tag',
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
