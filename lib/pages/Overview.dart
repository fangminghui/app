import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'dart:async';

import 'package:flutter_screenutil/screenutil.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  Response response;
  var data;
  void _getData() async {
    try {
      var url = 'http://10.0.2.13:8080/api/lss/overview';
      response = await Dio().get(url);
      var responseData = jsonDecode(response.toString());
      setState(() {
        data = responseData['data'];
        print(data);
      });
    } catch (e) {
      setState(() {
        data = [
          {'name': '无数据', 'value': '无数据'},
          {'name': '无数据', 'value': '无数据'},
          {'name': '无数据', 'value': '无数据'},
          {'name': '无数据', 'value': '无数据'},
          {'name': '无数据', 'value': '无数据'}
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      data = [
        {'name': '无数据', 'value': '无数据'},
        {'name': '无数据', 'value': '无数据'},
        {'name': '无数据', 'value': '无数据'},
        {'name': '无数据', 'value': '无数据'},
        {'name': '无数据', 'value': '无数据'}
      ];
    });
    _getData();
    const timeout = const Duration(seconds: 5);
    Timer.periodic(timeout, (timer) {
      _getData();
    });

    // Enable hybrid composition.
  }

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        decoration: BoxDecoration(
          border: new Border.all(
            color: Color(0x66000000),
            width: ScreenUtil().setWidth(1),
          ),
          color: Color(0x40ffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(data[2]['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: new Color(0xff444444))),
                    Text(data[2]['value'], style: TextStyle(fontSize: 25)),
                  ],
                ),
                Column(
                  children: [
                    Text(data[3]['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: new Color(0xff444444))),
                    Text(data[3]['value'], style: TextStyle(fontSize: 25)),
                  ],
                ),
                Column(
                  children: [
                    Text(data[4]['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: new Color(0xff444444))),
                    Text(data[4]['value'], style: TextStyle(fontSize: 25)),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
