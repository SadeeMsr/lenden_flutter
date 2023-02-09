import 'package:flutter/material.dart';
import 'package:lenden/views/permissions-views/EmailUsage.views.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    // home: const MyHomePage(),
    // home: const EmailUsage(),
    routes: {
      '/': (context) => EmailUsage(),
    },
  ));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lenden'),
      ),
    );
  }
}
