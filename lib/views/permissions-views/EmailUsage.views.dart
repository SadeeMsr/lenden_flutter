import 'package:flutter/material.dart';

class EmailUsage extends StatefulWidget {
  const EmailUsage({super.key});

  @override
  State<EmailUsage> createState() => EmailUsageState();
}

class EmailUsageState extends State<EmailUsage> {
  Widget titleSection = Container(
    padding: const EdgeInsets.all(10),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                spacing: 8.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  Text(
                    'Email Usage',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget textSection = const Padding(
    padding: EdgeInsets.all(30),
    child: Text(
        "This sections asks for permission to access your email activity? This will allow us to better understand your communication patterns and help us provide more personalized and efficient support. Rest assured that your privacy will be fully respected and all information will be kept confidential. Please let us know if you have any concerns or questions before granting access.",
        softWrap: true,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Color.fromARGB(255, 79, 72, 72))),
  );

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: const Color.fromARGB(255, 163, 195, 227),
    minimumSize: const Size(150, 44),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(25, 40, 25, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ButtonBar(),
          Center(
              child: Image.asset(
            'assets/images/gmail.png',
            height: 300,
            width: 300,
          )),
          const Center(
            child: Text(
              'Email Usage',
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
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/AppUsage',
                      arguments:
                          'Soyef, App usage a data emne routing diya pathailam dekh',
                    );
                  },
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
