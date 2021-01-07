import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class About extends StatelessWidget {
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
        title: Text("关于本软件",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: <Widget>[
          MyBackground(),
          MyLogo(),
          MyText(),
          Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(600)),
              child: Column(
                children: [
                  MyButton(tag: '功能介绍'),
                  MyButton(tag: '反馈'),
                  MyButton(tag: '检查新版本')
                ],
              ))
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
      color: Color(0xfff8f8f8),
    );
  }
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(250),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/logo.png"),
      )),
    );
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(250),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(380)),
      child: Text(
        "黄山景区供水V1.0.0",
        style: TextStyle(
            color: new Color(0xff333333),
            fontSize: ScreenUtil().setSp(48),
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none),
        textAlign: TextAlign.center,
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
        height: ScreenUtil().setHeight(120),
        decoration: BoxDecoration(
          border: new Border.symmetric(
            horizontal: BorderSide(
              color: Color(0xffccccccc),
              width: ScreenUtil().setWidth(1),
            ),
          ),
          color: Color(0xffffffff),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(20)),
        child: InkWell(
          onTap: () {
            if (tag == '功能介绍') {
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return MyFuncInfo();
                  });
            } else if (tag == '反馈') {
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return MyFeedBack();
                  });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tag,
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

class MyFuncInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('功能介绍'),
      content: Text('功能介绍'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('确认'),
        ),
      ],
    );
  }
}

class MyFeedBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('反馈'),
      content: Text('反馈'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('确认'),
        ),
      ],
    );
  }
}
