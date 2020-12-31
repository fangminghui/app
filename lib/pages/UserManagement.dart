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
      initialUrl: 'http://120.26.160.203:8082/UserManagement',
      // initialUrl: 'http://192.168.0.108:8080/UserManagement',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}

class UserManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1080, 1920), allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: Colors.white,
        toolbarHeight: ScreenUtil().setHeight(100),
        title: Text("用户管理",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: WebViewExample(),
      resizeToAvoidBottomPadding: false,
    );
  }
}
