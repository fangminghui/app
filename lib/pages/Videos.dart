import 'dart:io';

import 'package:flutter_screenutil/screenutil.dart';
import 'package:webview_flutter/platform_interface.dart';
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
      onWebResourceError: (
        WebResourceError webviewerrr,
      ) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('提示'),
                content: Text('网络错误，请检查后重试'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('确认'),
                  ),
                ],
              );
            });
      },
      initialUrl: 'http://10.0.2.13:8082/Videos',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}

class Videos extends StatelessWidget {
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
        backgroundColor: Color(0xfff3f3f3),
        toolbarHeight: ScreenUtil().setHeight(100),
        title: Text("视频监控",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: WebViewExample(),
      resizeToAvoidBottomPadding: false,
    );
  }
}
