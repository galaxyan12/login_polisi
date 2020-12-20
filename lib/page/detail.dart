import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import '../utils/constants.dart';

class Detail extends StatelessWidget {
  final int idArtikel;

  Detail(this.idArtikel);

  String apiUrl(id) {
    return Constants.apiUrl + "pages/$id";
  }

  Future<List<dynamic>> fetchApiData(int id) async {
    // var result = await http.get(apiUrl);
    // String token =
    // "ad17eee95360a48643c8dcbcf9ff01f77f5c3320910f238429e5a690fdc1f549";
    final response = await http.get(apiUrl(id), headers: {
      'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      // 'Authorization': 'Bearer $token',
    });
    // print('Token : ${token}');
    print(response);
    return json.decode(response.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1),
        child: FutureBuilder<List<dynamic>>(
            future: fetchApiData(this.idArtikel),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Text(
                      snapshot.data[0]['judul'].toUpperCase(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Html(data: snapshot.data[0]['isi'])
                ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
