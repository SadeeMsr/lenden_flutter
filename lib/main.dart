import 'package:flutter/material.dart';
import 'package:lenden/views/permissions-views/EmailUsage.views.dart';
import 'package:lenden/form/qp7.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    // home: const MyHomePage(),
    // home: const EmailUsage(),
    routes: {
      '/': (context) => const Qp7(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Lenden',
//             style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
//         backgroundColor: Colors.blueAccent,
//       ),
//     );
//   }
// }
