import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_net_storage/data_model.dart';
import 'package:http/http.dart' as http;

///Future与FutureBuilder实战应用
class FutureStudy extends StatefulWidget {
  const FutureStudy({super.key});

  @override
  State<FutureStudy> createState() => _FutureStudyState();
}

class _FutureStudyState extends State<FutureStudy> {
  String showResult = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Future与FutureBuilder实用技巧'),
        ),
        body: FutureBuilder<DataModel>(
          future: fetchGet(),
          builder: (BuildContext context, AsyncSnapshot<DataModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('state none');
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return const Text('state active');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return Column(children: <Widget>[
                    Text('code:${snapshot.data?.code}'),
                    Text('requestPrams:${snapshot.data?.data?.requestPrams}'),
                  ]);
                }
            }
          },
        ),
      ),
    );
  }

  Future<DataModel> fetchGet() async {
    var uri = Uri.parse("https://api.geekailab.com/uapi/test/test?requestPrams=11");
    final response = await http.get(uri);
    Utf8Decoder utf8decoder = const Utf8Decoder(); //fix 中文乱码
    var result = json.decode(utf8decoder.convert(response.bodyBytes));
    return DataModel.fromJson(result);
  }
}
