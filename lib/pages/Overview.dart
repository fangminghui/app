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
        if (double.parse(responseData['data'][0]['value']) > 0) {
          data[0]['value'] = responseData['data'][0]['value'];
        }
        if (double.parse(responseData['data'][1]['value']) > 0) {
          data[1]['value'] = responseData['data'][1]['value'];
        }
        if (double.parse(responseData['data'][2]['value']) > 0) {
          data[2]['value'] = responseData['data'][2]['value'];
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        data = [
          {'name': '今日耗电总量', 'value': '无数据'},
          {'name': '今日总出厂流量', 'value': '无数据'},
          {'name': '千吨水耗电量', 'value': '无数据'}
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      data = [
        {'name': '今日耗电总量', 'value': '无数据'},
        {'name': '今日总出厂流量', 'value': '无数据'},
        {'name': '千吨水耗电量', 'value': '无数据'}
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
                    Text(data[0]['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.5,
                            color: new Color(0xff444444))),
                    Text(data[0]['value'] + '(kw.h)',
                        style: TextStyle(fontSize: 15.5)),
                  ],
                ),
                Column(
                  children: [
                    Text(data[1]['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.5,
                            color: new Color(0xff444444))),
                    Text(data[1]['value'] + '(m³)',
                        style: TextStyle(fontSize: 15.5)),
                  ],
                ),
                Column(
                  children: [
                    Text(data[2]['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.5,
                            color: new Color(0xff444444))),
                    Text(data[2]['value'] + '(kw.h)',
                        style: TextStyle(fontSize: 15.5)),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
