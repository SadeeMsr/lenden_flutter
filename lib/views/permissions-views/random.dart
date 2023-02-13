import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  @override
  void initState() {
    super.initState();
  }

  void getNoSms() async {
    int no_sms = 0;
    int no_contacts = 0;

    if (!await FlutterContacts.requestPermission(readonly: true)) {
      print("denied");
    } else {
      final contacts = await FlutterContacts.getContacts();
      no_contacts = contacts.length;
    }
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages =
          await _query.querySms(kinds: [SmsQueryKind.inbox, SmsQueryKind.sent]);
      no_sms = messages.length;
    } else {
      await Permission.sms.request();
    }
    var bodys = json.encode({
      'userId': "shoaibvice@gmail.com",
      'no_contacts': no_contacts,
      "no_sms": no_sms
    });

    var url = Uri.parse('http://127.0.0.1:8000/addMobileFpData/');

    var resp = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: bodys);

    print(resp.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _messages.length,
            itemBuilder: (BuildContext context, int i) {
              var message = _messages[i];

              return ListTile(
                title: Text('${message.sender} [${message.date}]'),
                subtitle: Text('${message.body}'),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getNoSms,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
