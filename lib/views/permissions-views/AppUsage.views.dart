import 'dart:convert';
import 'dart:io';

import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppUsageData extends StatefulWidget {
  final String data;

  const AppUsageData({Key? key, required this.data}) : super(key: key);

  @override
  State<AppUsageData> createState() => _AppUsageState();
}

class _AppUsageState extends State<AppUsageData> {
  @override
  void initState() {
    super.initState();
    getUsagePerm();
  }

  void getUsagePerm() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(hours: 1440));
    List<AppUsageInfo> infoList =
        await AppUsage().getAppUsage(startDate, endDate);
  }

  List<AppUsageInfo> _infos = [];

  void getUsageStats() async {
// -------------------------------------AppUsage----------------------------------------------------
    List<Object> dataCollected = [];

    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(hours: 1440));
    List<AppUsageInfo> infoList =
        await AppUsage().getAppUsage(startDate, endDate);

    for (var info in infoList) {
      dataCollected
          .add({"appName": info.appName, "usage": info.usage.toString()});
    }

    var bodys = json.encode({
      'userId': widget.data,
      'app_log': {"list": dataCollected}
    });

    var url = Uri.parse('http://shababe.pythonanywhere.com/addAppUsageData/');

    var resp = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: bodys);

    print(resp.statusCode);
// ----------------------------AppList-------------------------------------------------------------------
    List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);

    List<Object> applist = [];

    for (var app in apps) {
      applist.add({"appName": app.packageName});
    }

    bodys = json.encode({
      'userId': widget.data,
      'app_list': {"list": applist}
    });

    url = Uri.parse('http://shababe.pythonanywhere.com/addSocialFpData/');

    resp = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: bodys);

    print(resp.statusCode);

    Navigator.of(context).pushNamed(
      '/phoneData',
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
            'assets/images/gmail.png',
            height: 300,
            width: 300,
          )),
          const Center(
            child: Text(
              "App Usage",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color.fromARGB(255, 55, 63, 98)),
              textAlign: TextAlign.center,
            ),
          ),
          const Center(
            child: Text(
                'This sections asks for permission to access your App Usage data? This will allow us to better understand your behavioral patterns and help us provide more personalized and efficient support. Rest assured that your privacy will be fully respected and all information will be kept confidential. Please let us know if you have any concerns or questions before granting access.',
                style: TextStyle(
                  color: Color.fromARGB(255, 87, 85, 86),
                  decorationThickness: 2.85,
                ),
                textAlign: TextAlign.justify),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
              child: FilledButton(
                  onPressed: getUsageStats,
                  style: FilledButton.styleFrom(
                      backgroundColor: Color.fromARGB(188, 37, 51, 94)),
                  child: const Text('Next')),
            ),
          ),
        ],
      ),
    ));
  }
}
