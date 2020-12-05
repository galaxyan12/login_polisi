import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// class WatpresList extends StatelessWidget {
//   final String apiUrl =
//       "http://sdmpolda.kawansaye.net/api/pages/category/watpres";
//   Future<List<dynamic>> fetchDalpers() async {
//     // var result = await http.get(apiUrl);
//     // String token =
//     //     "ad17eee95360a48643c8dcbcf9ff01f77f5c3320910f238429e5a690fdc1f549";
//     final response = await http.get(apiUrl, headers: {
//       'Content-Type': 'application/json',
//       // 'Accept': 'application/json',
//       // 'Authorization': 'Bearer $token',
//     });
//     // print('Token : ${token}');
//     print(response);
//     return json.decode(response.body)['data'];
//   }

//   String _judul(dynamic dalper) {
//     return dalper['judul'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Watpres List'),
//       ),
//       body: Container(
//         child: FutureBuilder<List<dynamic>>(
//           future: fetchDalpers(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                   padding: EdgeInsets.all(8),
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Card(
//                       color: Colors.white,
//                       child: Column(
//                         children: <Widget>[
//                           new Container(
//                               decoration:
//                                   new BoxDecoration(color: Colors.lightGreen),
//                               child: new ListTile(
//                                 // leading: CircleAvatar(
//                                 //   radius: 30,
//                                 //   backgroundImage: NetworkImage(snapshot.data[index]['picture']['large'])),
//                                 title: Text(_judul(snapshot.data[index])),
//                                 // subtitle: Text(_location(snapshot.data[index])),
//                                 // trailing: Text(_age(snapshot.data[index])),
//                               ))
//                         ],
//                       ),
//                     );
//                   });
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// secondary option
class WatpresList extends StatefulWidget {
  @override
  _WatpresListState createState() => _WatpresListState();
}

class _WatpresListState extends State<WatpresList> {
  int _counter;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watpres'),
      ),
      body: Center(
        child: Text('Watpres $_counter'),
      ),
    );
  }
}
