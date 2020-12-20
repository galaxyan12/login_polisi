import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail.dart';
import 'dart:convert';
import '../utils/constants.dart';

class GeneralList extends StatelessWidget {
  final String listName;

  GeneralList(this.listName);

  String apiUrl(String theName) {
    return Constants.apiUrl + 'pages/category/$theName';
  }

  Future<List<dynamic>> fetchDalpers() async {
    // var result = await http.get(apiUrl);
    // String token =
    // "ad17eee95360a48643c8dcbcf9ff01f77f5c3320910f238429e5a690fdc1f549";
    final response = await http.get(apiUrl(this.listName), headers: {
      'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      // 'Authorization': 'Bearer $token',
    });
    // print('Token : ${token}');
    print(response);
    var hasil = new List();
    hasil.add(json.decode(response.body)['data']);
    hasil.add(json.decode(response.body)['desc']);
    return hasil;
  }

  String _judul(dynamic dalper) {
    return dalper['judul'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.listName.toUpperCase()),
      ),
      // body: Text(apiUrl(this.listName)),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchDalpers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(snapshot.data[1].toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ListView.builder(
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(8),
                        itemCount: snapshot.data[0].length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Detail(snapshot.data[0][index]['id']);
                              }));
                            },
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  new Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.lightGreen),
                                      child: new ListTile(
                                        // leading: CircleAvatar(
                                        //   radius: 30,
                                        //   backgroundImage: NetworkImage(snapshot.data[index]['picture']['large'])),
                                        title: Text(
                                            _judul(snapshot.data[0][index])),
                                        // subtitle:
                                        //     Text(_judul(snapshot.data[0][index])),
                                        // trailing: Text(_age(snapshot.data[index])),
                                      ))
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: FloatingActionButton.extended(
          onPressed: () {
            print('masuk');
          },
          label: Text('Hubungi Kami'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
