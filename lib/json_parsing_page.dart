import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_net_storage/data_model.dart';

///JSON解析与Dart Model的使用
class JsonParsingPage extends StatefulWidget {
  const JsonParsingPage({super.key});

  @override
  State<JsonParsingPage> createState() => _JsonParsingPageState();
}

class _JsonParsingPageState extends State<JsonParsingPage> {
  var resultShow = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON解析与Dart Model的实战应用'),
      ),
      body: Column(
        children: [_json2MapBtn(), _json2ModelBtn(), Text("结果：$resultShow")],
      ),
    );
  }

  _json2MapBtn() {
    return ElevatedButton(onPressed: _json2Map, child: const Text('json转Map'));
  }

  _json2ModelBtn() {
    return ElevatedButton(onPressed: _json2Model, child: const Text('json转Model'));
  }

  //json转map并解析数据
  void _json2Map() {
    var jsonString =
        '{ "code": 0, "data": { "code": 0, "method": "POST", "jsonParams": { "json": "123" } }, "msg": "SUCCESS." }';
    Map<String, dynamic> map = jsonDecode(jsonString);
    setState(() {
      resultShow = 'code：${map['code']}; jsonParams：${map['data']['jsonParams']}';
    });
  }

//json转Model
  void _json2Model() {
    var jsonString = '{"code":0,"data":{"code":0,"method":"GET","requestPrams":"11"},"msg":"SUCCESS."}';
    Map<String, dynamic> map = jsonDecode(jsonString); //json转成Map
    DataModel model = DataModel.fromJson(map); //将map转成Dart Model
    setState(() {
      resultShow = 'code:${model.code};requestPrams：${model.data?.requestPrams}';
    });
  }
}
