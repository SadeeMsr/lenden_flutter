import 'package:flutter/material.dart';

class ImageQues extends StatefulWidget {
  const ImageQues({super.key});

  @override
  State<ImageQues> createState() => _ImageQuesState();
}

class _ImageQuesState extends State<ImageQues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Which person in the image is more like you?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        const SizedBox(height: 10),
        const Text(
          '(Please select one)',
          style:
              TextStyle(fontSize: 15, color: Color.fromARGB(199, 90, 88, 88)),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: Color.fromARGB(255, 216, 215, 215),
                      width: 4.0,
                      style: BorderStyle.solid),
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/quesSeven',
                      );
                    },
                    child: Image.asset(
                      'assets/images/lonely.png',
                      height: 180,
                      width: 180,
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: Color.fromARGB(255, 216, 215, 215),
                      width: 4.0,
                      style: BorderStyle.solid),
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/quesSeven',
                      );
                    },
                    child: Image.asset(
                      'assets/images/team.png',
                      height: 180,
                      width: 180,
                    )),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
