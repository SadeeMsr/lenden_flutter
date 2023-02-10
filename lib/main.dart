import 'package:flutter/material.dart';
import 'package:lenden/views/permissions-views/PhoneData.views.dart';
import 'package:lenden/views/permissions-views/EmailUsage.views.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    routes: {
      // '/': (context) => const EmailUsage(),
      '/': (context) => const PhoneData()
    },
    debugShowCheckedModeBanner: false,
  ));
}
