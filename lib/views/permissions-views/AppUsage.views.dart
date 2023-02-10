import 'package:flutter/material.dart';

class AppUsage extends StatefulWidget {
  const AppUsage({super.key});

  @override
  State<AppUsage> createState() => _AppUsageState();
}

class _AppUsageState extends State<AppUsage> {
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
              'App Usage',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color.fromARGB(255, 55, 63, 98)),
              textAlign: TextAlign.center,
            ),
          ),
          const Center(
            child: Text(
                'This sections asks for permission to access your email activity? This will allow us to better understand your communication patterns and help us provide more personalized and efficient support. Rest assured that your privacy will be fully respected and all information will be kept confidential. Please let us know if you have any concerns or questions before granting access.',
                style: TextStyle(
                  color: Color.fromARGB(255, 87, 85, 86),
                  decorationThickness: 2.85,
                ),
                textAlign: TextAlign.justify),
          ),
          const Center(
            child: Text(
                'Rest assured that your privacy will be fully respected and all information will be kept confidential. Please let us know if you have any concerns or questions before granting access.',
                style: TextStyle(
                  color: Color.fromARGB(255, 87, 85, 86),
                  decorationThickness: 2.85,
                ),
                textAlign: TextAlign.justify),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Center(
              child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      backgroundColor: Color.fromARGB(188, 37, 51, 94)),
                  child: const Text('Give permissions')),
            ),
          )
        ],
      ),
    ));
  }
}
