import 'package:flutter/material.dart';

class Qp7 extends StatefulWidget {
  const Qp7({super.key});

  @override
  State<Qp7> createState() => Qp7State();
}

class Qp7State extends State<Qp7> {
  var _health = 0;
  var _home = 0;
  var _vacation = 0;
  var _entertaiment = 0;
//Home -----------------------------------------------------------------------------------------------
  Widget homeBox() => Container(
        width: double.infinity,
        height: 80.0,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 255, 254, 254),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 185, 212, 186), spreadRadius: 3),
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text('$_home',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (_home > 0 && _home <= 10) {
                    setState(() {
                      _home--;
                    });
                  }
                },
                child: Icon(Icons.remove),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("or"),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  if (_home >= 0 && _home < 10) {
                    setState(() {
                      _home++;
                    });
                  }
                },
                child: new Icon(Icons.add),
              )
            ],
          ),
        ]),
      );
//Health -----------------------------------------------------------------------------------------------
  Widget healthBox() => Container(
        width: double.infinity,
        height: 80.0,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 255, 254, 254),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 185, 212, 186), spreadRadius: 3),
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
            "Health",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text('$_health',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (_health > 0 && _health <= 10) {
                    setState(() {
                      _health--;
                    });
                  }
                },
                child: const Icon(Icons.remove),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("or"),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  if (_health >= 0 && _health < 10) {
                    setState(() {
                      _health++;
                    });
                  }
                },
                child: new Icon(Icons.add),
              )
            ],
          ),
        ]),
      );
//Vacation -----------------------------------------------------------------------------------------------
  Widget vacationBox() => Container(
        width: double.infinity,
        height: 80.0,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 255, 254, 254),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 185, 212, 186), spreadRadius: 3),
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
            "Vacation",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text('$_vacation',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (_vacation > 0 && _vacation <= 10) {
                    setState(() {
                      _vacation--;
                    });
                  }
                },
                child: new Icon(Icons.remove),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("or"),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  if (_vacation >= 0 && _vacation < 10) {
                    setState(() {
                      _vacation++;
                    });
                  }
                },
                child: new Icon(Icons.add),
              )
            ],
          ),
        ]),
      );
//Entertainment -----------------------------------------------------------------------------------------------
  Widget entertainmentBox() => Container(
        width: double.infinity,
        height: 80.0,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 255, 254, 254),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 185, 212, 186), spreadRadius: 3),
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
            "Entertainment",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text('$_entertaiment',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (_entertaiment > 0 && _entertaiment <= 10) {
                    setState(() {
                      _entertaiment--;
                    });
                  }
                },
                child: new Icon(Icons.remove),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("or"),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  if (_entertaiment >= 0 && _entertaiment < 10) {
                    setState(() {
                      _entertaiment++;
                    });
                  }
                },
                child: Icon(Icons.add),
              )
            ],
          ),
        ]),
      );
  Widget titleSection = Container(
    padding: const EdgeInsets.all(20),
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
                    'Psychometric',
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
    padding: EdgeInsets.all(20),
    child: Text(
        "Q) Assume you have 10 coins of unexpected income, how would you prefer to allocate this income in the following categories ?",
        softWrap: true,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Color.fromARGB(255, 2, 2, 2))),
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
        titleSection,
        textSection,
        homeBox(),
        healthBox(),
        vacationBox(),
        entertainmentBox(),
        Container(
          //apply margin and padding using Container Widget.
          padding: const EdgeInsets.all(25), //You can use EdgeInsets like above
          margin: const EdgeInsets.all(5),
          child: ElevatedButton(
            style: raisedButtonStyle,
            onPressed: () {
              if (_entertaiment + _health + _home + _vacation <= 10) {
                //Code to change screen
              } else {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Alert'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    content: const Text(
                        'Make sure the coins alloted add up to 10 or less'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
              Navigator.of(context).pushNamed(
                '/survey',
              );
            },
            child: const Text('Next'),
          ),
        ),
      ]),
    );
  }
}
