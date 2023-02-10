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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lenden',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: const Color.fromARGB(255, 66, 87, 123),
      ),
      body: Column(children: [
        const SizedBox(
            width: double.infinity,
            height: 300.00,
            child: Image(image: AssetImage("assets/email.jpg"))),
        titleSection,
        textSection,
        Container(
          //apply margin and padding using Container Widget.
          padding: const EdgeInsets.all(25), //You can use EdgeInsets like above
          margin: const EdgeInsets.all(5),
          child: ElevatedButton(
            style: raisedButtonStyle,
            onPressed: () {},
            child: const Text('Give Permission'),
          ),
        ),
      ]),
    );
  }
}
