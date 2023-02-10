import 'package:flutter/material.dart';
import 'package:lenden/views/permissions-views/PhoneData.views.dart';
// import 'package:lenden/views/permissions-views/EmailUsage.views.dart';

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
