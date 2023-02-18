    // var bodyAsBytes = utf8.encode(body);

    // response = await http.post(_batchGmailUrl,
    //     headers: {
    //       'Authorization': 'Bearer $accessToken',
    //       'Host': 'www.googleapis.com',
    //       'Content-Type': 'multipart/mixed; boundary=$boundary'
    //     },
    //     body: bodyAsBytes);

    // List<Object> dataCollected = [
    //   {"messages": response.body}
    // ];

    // var bodys = json.encode({
    //   'userId': userId,
    //   'email_log': {"list": dataCollected}
    // });

    // var url = Uri.parse('http://lenden.xyz.marwabd.com/addEmailData/');
    // print("hello");
    // try {
    //   var resp = await http
    //       .post(url, headers: {"Content-Type": "application/json"}, body: bodys)
    //       .catchError((_) => print('Logging message failed'));
    //   print(resp.statusCode);
    // } on SocketException {
    //   print("error");
    // }
// // -----------------------------------------------------------sent emails-----------------------------------------------------------------------------------
//     http.Response response = await http.get(
//       Uri.parse(
//           'https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=500&q="in:sent after:2019/01/01 before:$year/$month/$date'),
//       headers: await user.authHeaders,
//     );

//     Map<String, dynamic> data =
//         json.decode(response.body) as Map<String, dynamic>;

//     // var pgToken = data["nextPageToken"];
//     // if (pgToken != null) {
//     //   while (pgToken != null && data["messages"].length <= 500) {
//     //     http.Response respo = await http.get(
//     //       Uri.parse(
//     //           'https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=500&pageToken=$pgToken&q="in:sent after:2019/01/01 before:$year/$month/$date'),
//     //       headers: await user.authHeaders,
//     //     );
//     //     Map<String, dynamic> tempdata =
//     //         json.decode(respo.body) as Map<String, dynamic>;
//     //     data.addAll(tempdata);
//     //     pgToken = tempdata["nextPageToken"];
//     //   }
//     // }

//     for (int i = 0; i < 10; i++) {
//       var emId = data["messages"][i]["id"];

//       http.Response emailMsg = await http.get(
//         Uri.parse(
//             'https://gmail.googleapis.com/gmail/v1/users/me/messages/$emId'),
//         headers: await user.authHeaders,
//       );

//       final Map<String, dynamic> emailData =
//           json.decode(emailMsg.body) as Map<String, dynamic>;

//       var body = json.encode({'userId': userId, 'email_log': emailData});

//       var url = Uri.parse('http://lenden.xyz.marwabd.com/addEmailData/');

//       try {
//         var resp = await http
//             .post(url,
//                 headers: {"Content-Type": "application/json"}, body: body)
//             .catchError((_) => print('Logging message failed'));
//       } on SocketException {
//         print("error on $i");
//         continue;
//       }
//     }

//     // -----------------------------------------------------------Inbox emails-----------------------------------------------------------------------------------
//     response = await http.get(
//       Uri.parse(
//           'https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=500&q="in:inbox after:2019/01/01 before:$year/$month/$date'),
//       headers: await user.authHeaders,
//     );

//     data = json.decode(response.body) as Map<String, dynamic>;

//     for (int i = 0; i < 10; i++) {
//       var emId = data["messages"][i]["id"];

//       http.Response emailMsg = await http.get(
//         Uri.parse(
//             'https://gmail.googleapis.com/gmail/v1/users/me/messages/$emId'),
//         headers: await user.authHeaders,
//       );

//       final Map<String, dynamic> emailData =
//           json.decode(emailMsg.body) as Map<String, dynamic>;

//       var body = json.encode({'userId': userId, 'email_log': emailData});

//       var url = Uri.parse('http://lenden.xyz.marwabd.com/addEmailData/');

//       try {
//         var resp = await http
//             .post(url,
//                 headers: {"Content-Type": "application/json"}, body: body)
//             .catchError((_) => print('Logging message failed'));
//       } on SocketException {
//         print("error on $i");
//         continue;
//       }
//     }



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