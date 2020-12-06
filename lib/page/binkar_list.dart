import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BinkarList extends StatelessWidget {
  final String apiUrl =
      "https://sdmpolda.kawansaye.net/api/pages/category/binkar";
  Future<List<dynamic>> fetchDalpers() async {
    // var result = await http.get(apiUrl);
    // String token = "ad17eee95360a48643c8dcbcf9ff01f77f5c3320910f238429e5a690fdc1f549";
    final response = await http.get(apiUrl, headers: {
      'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      // 'Authorization': 'Bearer $token',
    });
    // print('Token : ${token}');
    print(response);
    return json.decode(response.body)['data'];
  }

  String _judul(dynamic dalper) {
    return dalper['judul'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Binkar List'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchDalpers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          new Container(
                              decoration:
                                  new BoxDecoration(color: Colors.lightGreen),
                              child: new ListTile(
                                // leading: CircleAvatar(
                                //   radius: 30,
                                //   backgroundImage: NetworkImage(snapshot.data[index]['picture']['large'])),
                                title: Text(_judul(snapshot.data[index])),
                                // subtitle: Text(_location(snapshot.data[index])),
                                // trailing: Text(_age(snapshot.data[index])),
                              ))
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
