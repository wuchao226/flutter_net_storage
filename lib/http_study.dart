import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpStudy extends StatefulWidget {
  const HttpStudy({super.key});

  @override
  _HttpStudyState createState() => _HttpStudyState();
}

class _HttpStudyState extends State<HttpStudy> {
  var resultShow = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('基于Http实现网络操作'),
      ),
      body: Column(children: <Widget>[
        _doGetBtn(),
        Text("返回结果：$resultShow"),
      ]),
    );
  }

  _doGetBtn() {
    return ElevatedButton(onPressed: _doGet, child: const Text('发送Get请求'));
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
}
