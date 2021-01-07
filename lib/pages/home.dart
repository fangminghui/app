import 'package:app/pages/Monitor.dart';
import 'package:app/pages/GIS.dart';
import 'package:app/pages/Videos.dart';
import 'package:app/pages/DataReview.dart';
import 'package:app/pages/DataCompare.dart';
import 'package:app/pages/DataPredict.dart';
import 'package:app/pages/WarningMessage.dart';
import 'package:app/pages/EquipmentManagement.dart';
import 'package:app/pages/WarningManagement.dart';
import 'package:app/pages/UserManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/pages/setting.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1080, 1920), allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff3f3f3),
        toolbarHeight: ScreenUtil().setHeight(100),
        title: Text("主页",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(top: 0, child: MyBackground()),
          Column(
            children: [
              Row(
                children: [
                  MyButton(tag: "运行监测", assetName: "assets/svg/one.svg"),
                  MyButton(tag: "管网系统", assetName: "assets/svg/two.svg"),
                  MyButton(tag: "视频监控", assetName: "assets/svg/three.svg"),
                  MyButton(tag: "数据回顾", assetName: "assets/svg/four.svg"),
                ],
              ),
              Row(
                children: [
                  MyButton(tag: "数据对比", assetName: "assets/svg/five.svg"),
                  MyButton(tag: "供水预测", assetName: "assets/svg/six.svg"),
                  MyButton(tag: "报警信息", assetName: "assets/svg/seven.svg"),
                  MyButton(tag: "仪器设备", assetName: "assets/svg/eight.svg"),
                ],
              ),
              Row(
                children: [
                  MyButton(tag: "警报管理", assetName: "assets/svg/nine.svg"),
                  MyButton(tag: "用户管理", assetName: "assets/svg/ten.svg"),
                  MyButton(tag: "设置", assetName: "assets/svg/setting.svg"),
                ],
              ),
            ],
          )
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
              alignment: Alignment.center)),
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton({Key key, this.tag, this.assetName}) : super(key: key);
  final String tag;
  final String assetName;
  @override
  Widget build(BuildContext context) {
    Widget svg = SvgPicture.asset(
      '$assetName',
      width: MediaQuery.of(context).size.width / 8,
    );
    return Container(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.width / 4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: new Border.all(
            color: Color(0x66000000),
            width: ScreenUtil().setWidth(1),
          ),
          color: Color(0x40ffffff),
        ),
        child: InkWell(
          onTap: () {
            Widget page = Setting();
            switch (tag) {
              case '运行监测':
                {
                  page = Monitor();
                }
                break;
              case '管网系统':
                {
                  page = GIS();
                }
                break;
              case '视频监控':
                {
                  page = Videos();
                }
                break;
              case '数据回顾':
                {
                  page = DataReview();
                }
                break;
              case '数据对比':
                {
                  page = DataCompare();
                }
                break;
              case '供水预测':
                {
                  page = DataPredict();
                }
                break;
              case '报警信息':
                {
                  page = WarningMessage();
                }
                break;
              case '仪器设备':
                {
                  page = EquipmentManagement();
                }
                break;
              case '警报管理':
                {
                  page = WarningManagement();
                }
                break;
              case '用户管理':
                {
                  page = UserManagement();
                }
                break;
              case '设置':
                {
                  page = Setting();
                }
                break;
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svg,
              Text(
                '$tag',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}
