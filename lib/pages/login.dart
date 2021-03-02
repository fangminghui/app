import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:app/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/components/loadingDialog.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1080, 1920), allowFontScaling: true);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MyBackground(),
          MyLogo(),
          MyForm(),
          MyText(),
        ],
      ),
      resizeToAvoidBottomPadding: false,
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
              alignment: Alignment.topLeft)),
    );
  }
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(250),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(300)),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/logo.png"),
      )),
    );
  }
}

class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(600),
        width: ScreenUtil().setWidth(900),
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(90), top: ScreenUtil().setHeight(600)),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(50)),
        color: Color(0x40ffffff),
        alignment: Alignment.center,
        child: MyFormContent());
  }
}

class MyFormContent extends StatefulWidget {
  @override
  _MyFormContentState createState() => _MyFormContentState();
}

class _MyFormContentState extends State<MyFormContent> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _saveUser(username, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
  }

  void _login() async {
    var url = 'http://10.0.2.13:8080/api/user/login/status?';
    var para =
        "loginName=${usernameController.text}&password=${passwordController.text}";
    var response = await http.get(url + para);
    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));
    if (responseJson['message'] == '验证成功') {
      _saveUser(usernameController.text, passwordController.text);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.pop(context);
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('用户名或密码错误'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('确认'),
                ),
              ],
            );
          });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          primaryColor: Colors.white,
        ),
        child: Form(
            key: _formKey,
            child: Container(
              height: ScreenUtil().setHeight(500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Color(0x66f8f8f8),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                            vertical: ScreenUtil().setHeight(25)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        hintText: " 请输入账号:",
                        hintStyle: TextStyle(fontSize: ScreenUtil().setSp(48)),
                        icon: Icon(
                          Icons.person_outline,
                          size: ScreenUtil().setSp(100),
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return ' 账号不能为空';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: passwordController,
                    decoration: new InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Color(0x66f8f8f8),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                            vertical: ScreenUtil().setHeight(25)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        hintText: " 请输入密码:",
                        hintStyle: TextStyle(fontSize: ScreenUtil().setSp(48)),
                        icon: Icon(
                          Icons.lock_outline,
                          size: ScreenUtil().setSp(100),
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '密码不能为空';
                      }
                      return null;
                    },
                  ),
                  Container(
                    width: ScreenUtil().setWidth(800),
                    height: ScreenUtil().setHeight(80),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff1296db)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: ScreenUtil().setSp(54)))),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return new LoadingDialog(
                                text: "账号登录中…",
                              );
                            });
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          // Process data.
                          _login();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Text('登录'),
                    ),
                  ),
                ],
              ),
            )));
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(250),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(1750)),
      child: Text(
        "合肥工业大学黄山水务团队\r\n@2020版权所有",
        style: TextStyle(
            color: new Color(0xffa0a0a0),
            fontSize: ScreenUtil().setSp(36),
            decoration: TextDecoration.none),
        textAlign: TextAlign.center,
      ),
    );
  }
}
