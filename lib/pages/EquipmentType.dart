import 'dart:io';

import 'package:flutter_screenutil/screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'http://182.61.34.157:8082/EquipmentType',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}

class EquipmentType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1080, 1920), allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff3f3f3),
        elevation: 0,
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
        toolbarHeight: ScreenUtil().setHeight(100),
        title: Text("设备类型",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: WebViewExample(),
      resizeToAvoidBottomPadding: false,
    );
  }
}