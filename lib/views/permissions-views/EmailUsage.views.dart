import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
    'https://mail.google.com/'
  ],
);

class EmailUsage extends StatefulWidget {
  const EmailUsage({super.key});

  @override
  State<EmailUsage> createState() => EmailUsageState();
}

class EmailUsageState extends State<EmailUsage> {
//-----------------Email data retrieval------------------------------------------------
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetEmail(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetEmail(GoogleSignInAccount user) async {
    //Getting todays date ------------------
    DateTime now = DateTime.now();
    var date = now.day;
    var month = now.month;
    var year = now.year;

    final http.Response profileData = await http.get(
      Uri.parse('https://gmail.googleapis.com/gmail/v1/users/me/profile'),
      headers: await user.authHeaders,
    );

    final Map<String, dynamic> pData =
        json.decode(profileData.body) as Map<String, dynamic>;

    var userId = pData["emailAddress"];
// -----------------------------------------------------------sent emails-----------------------------------------------------------------------------------
    http.Response response = await http.get(
      Uri.parse(
          'https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=500&q="in:sent after:2019/01/01 before:$year/$month/$date'),
      headers: await user.authHeaders,
    );

    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    // var pgToken = data["nextPageToken"];
    // if (pgToken != null) {
    //   while (pgToken != null && data["messages"].length <= 500) {
    //     http.Response respo = await http.get(
    //       Uri.parse(
    //           'https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=500&pageToken=$pgToken&q="in:sent after:2019/01/01 before:$year/$month/$date'),
    //       headers: await user.authHeaders,
    //     );
    //     Map<String, dynamic> tempdata =
    //         json.decode(respo.body) as Map<String, dynamic>;
    //     data.addAll(tempdata);
    //     pgToken = tempdata["nextPageToken"];
    //   }
    // }

    for (int i = 0; i < 10; i++) {
      var emId = data["messages"][i]["id"];

      http.Response emailMsg = await http.get(
        Uri.parse(
            'https://gmail.googleapis.com/gmail/v1/users/me/messages/$emId'),
        headers: await user.authHeaders,
      );

      final Map<String, dynamic> emailData =
          json.decode(emailMsg.body) as Map<String, dynamic>;

      var body = json.encode({'userId': userId, 'email_log': emailData});

      var url = Uri.parse('http://127.0.0.1:8000/addEmailData/');

      try {
        var resp = await http
            .post(url,
                headers: {"Content-Type": "application/json"}, body: body)
            .catchError((_) => print('Logging message failed'));
        print(resp.statusCode);
      } on SocketException {
        print("error on $i");
        continue;
      }
      print(i);
    }
    print("Sent email finished");

    // -----------------------------------------------------------Inbox emails-----------------------------------------------------------------------------------
    response = await http.get(
      Uri.parse(
          'https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=500&q="in:inbox after:2019/01/01 before:$year/$month/$date'),
      headers: await user.authHeaders,
    );

    data = json.decode(response.body) as Map<String, dynamic>;

    for (int i = 0; i < 10; i++) {
      var emId = data["messages"][i]["id"];

      http.Response emailMsg = await http.get(
        Uri.parse(
            'https://gmail.googleapis.com/gmail/v1/users/me/messages/$emId'),
        headers: await user.authHeaders,
      );

      final Map<String, dynamic> emailData =
          json.decode(emailMsg.body) as Map<String, dynamic>;

      var body = json.encode({'userId': userId, 'email_log': emailData});

      var url = Uri.parse('http://127.0.0.1:8000/addEmailData/');

      try {
        var resp = await http
            .post(url,
                headers: {"Content-Type": "application/json"}, body: body)
            .catchError((_) => print('Logging message failed'));
        print(resp.statusCode);
      } on SocketException {
        print("error on $i");
        continue;
      }
      print(i);
    }
    print("Inbox email finished");

    // ----------------------------------------------------------------------------------------------------------------------------------------------
    Navigator.of(context).pushNamed(
      '/AppUsage',
      arguments: userId,
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

//-----------------others---------------------------------------------------------------
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
    final GoogleSignInAccount? user = _currentUser;
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
            onPressed: () {
              _handleSignIn;
              Navigator.of(context).pushNamed(
                '/AppUsage',
                arguments:
                    'Soyef, App usage a data emne routing diya pathailam dekh',
              );
            },
            child: const Text('Give Permission'),
          ),
        ),
        // ElevatedButton(
        //   child: const Text('REFRESH'),
        //   onPressed: () => _handleGetEmail(user!),
        // ),
      ]),
    );
  }
}





// var emId = data["messages"][0]["id"];

    // final http.Response emailMsg = await http.get(
    //   Uri.parse(
    //       'https://gmail.googleapis.com/gmail/v1/users/me/messages/$emId'),
    //   headers: await user.authHeaders,
    // );

    // final Map<String, dynamic> emailData =
    //     json.decode(emailMsg.body) as Map<String, dynamic>;

    // print(emailData);

    // var body = json.encode({'userId': userId, 'email_log': emailData});

    // var url = Uri.parse('http://127.0.0.1:8000/addEmailData/');

    // var resp = await http.post(url,
    //     headers: {"Content-Type": "application/json"}, body: body);

    // print(resp.statusCode);
    // _googleSignIn.disconnect();