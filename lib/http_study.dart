import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpStudy extends StatefulWidget {
  const HttpStudy({super.key});

  @override
  _HttpStudyState createState() => _HttpStudyState();
}

class _HttpStudyState extends State<HttpStudy> {
  var resultShow = "";
  var resultShow2 = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('基于Http实现网络操作'),
      ),
      body: Column(children: <Widget>[
        _doGetBtn(),
        _doPostBtn(),
        _doPostJsonBtn(),
        Text("返回结果：$resultShow"),
        Text("解析的msg：$resultShow2"),
      ]),
    );
  }

  _doGetBtn() {
    return ElevatedButton(onPressed: _doGet, child: const Text('发送Get请求'));
  }

  _doPostBtn() {
    return ElevatedButton(onPressed: _doPost, child: const Text('发送Post请求'));
  }

  _doPostJsonBtn() {
    return ElevatedButton(onPressed: _doPostJson, child: const Text('发送Json格式的Post请求'));
  }

  ///发送Get请求
  _doGet() async {
    var uri = Uri.parse('https://api.geekailab.com/uapi/test/test?requestPrams=11');
    var response = await http.get(uri);
    //http请求成功
    if (response.statusCode == 200) {
      setState(() {
        resultShow = response.body;
      });
    } else {
      setState(() {
        resultShow = "请求失败：code: ${response.statusCode}，body:${response.body}";
      });
    }
  }

  ///发送Post请求
  _doPost() async {
    var uri = Uri.parse('https://api.geekailab.com/uapi/test/test');
    var params = {"requestPrams": "doPost"}; //数据格式要为Map<String, String>
    var response = await http.post(uri, body: params); //默认为x-www-form-urlencoded 格式
    //http请求成功
    if (response.statusCode == 200) {
      setState(() {
        resultShow = response.body;
      });
    } else {
      setState(() {
        resultShow = "请求失败：code: ${response.statusCode}，body:${response.body}";
      });
    }
  }

  ///发送Json类型的Post请求
  _doPostJson() async {
    var uri = Uri.parse('https://api.geekailab.com/uapi/test/testJson');
    var params = {"requestPrams": "doPost"};
    var response = await http.post(
      uri,
      body: json.encode(params), //将数据转成string
      headers: {
        //设置content-type为application/json
        "content-Type": "application/json",
      },
    );
    //http请求成功
    if (response.statusCode == 200) {
      setState(() {
        resultShow = response.body;
      });
      var map = jsonDecode(response.body);
      setState(() {
        resultShow2 = map["msg"];
      });
    } else {
      setState(() {
        resultShow = "请求失败：code: ${response.statusCode}，body:${response.body}";
      });
    }
  }
}
