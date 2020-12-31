import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/login.dart';
import 'package:minimize_app/minimize_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WillPopScope(
        child: IsLogin(),
        onWillPop: () async {
          MinimizeApp.minimizeApp();
          return false;
        },
      ),
    );
  }
}

class IsLogin extends StatefulWidget {
  @override
  _IsLoginState createState() => _IsLoginState();
}

class _IsLoginState extends State<IsLogin> {
  var isLogin;
  void initState() {
    super.initState();
    checkIsLogin();
  }

  checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('username') != null) {
      setState(() => isLogin = 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin == 1) {
      return Home();
    } else {
      return Login();
    }
  }
}
