import 'dart:async';
// import 'dart:convert';
// import 'package:fire_button/utilities/credential_util.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// class DangerReport {
//   final int id;
//   final String personel;
//   final String lat;
//   final String long;
//   String response;

//   DangerReport({this.id, this.personel, this.lat, this.long});
//   // DangerReport.hasil(response) {
//   //   this.response = response;
//   // }

//   factory DangerReport.fromJson(Map<String, dynamic> json) {
//     return DangerReport(
//       id: json['id'],
//       long: json['long'],
//     );
//   }
// }

class Beranda extends StatefulWidget {
  Beranda({Key key}) : super(key: key);
  static String tag = 'beranda';
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  var judul = 'Polda Kalbar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(76),
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Image(
                    height: 40,
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                Text(
                  judul,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BerandaPage(),
    );
  }
}

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  // String _token = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  //Loading counter value on start
  _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('token') ?? '');
  }

  Future<void> createDangerReport(String personel) async {
    // var hasilInternal;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude.toString();
    var long = position.longitude.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mtoken = (prefs.getString('token') ?? '');

    debugPrint('Dapat lat: $lat long: $long token: $mtoken');
    final http.Response response = await http.post(
      'http://sdmpolda.kawansaye.net/api/panic',
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + mtoken,
      },
      body: {
        // 'personel': personel,
        'lat': lat,
        'long': long,
      },
    );

    if (response.statusCode == 200) {
      // var hasilInternal = response.body;
    } else {
      throw Exception('Failed to create DangerReport.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final kotakLogo = Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(25),
        color: Colors.grey[850],
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
        ),
      ),
    );

    final tombolDalper = Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        color: Colors.blueGrey[100],
        child: FlatButton(
          onPressed: () async {
            Navigator.pushNamed(context, '/dalper');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var _detoken = (prefs.getString('token') ?? '');
            debugPrint('Hasil token' + _detoken);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Image(
                  width: 90,
                  // color: Colors.red[600],
                  image: AssetImage('assets/images/002-megaphone.png'),
                ),
              ),
              Text(
                'Dalper',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
    final tombolBinkar = Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        color: Colors.purple[400],
        child: FlatButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            final counter = prefs.getInt('counter') ?? 0;
            Navigator.pushNamed(context, '/binkar');
            debugPrint(counter.toString());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Image(
                  width: 90,
                  // color: Colors.red[600],
                  image: AssetImage('assets/images/003-policeman.png'),
                ),
              ),
              Text(
                'Binkar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
    final tombolPsikologi = Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.all(10),
        width: 50,
        color: Colors.red[400],
        child: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/psikologi');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Image(
                  width: 90,
                  // color: Colors.red[600],
                  image: AssetImage('assets/images/005-smartphone.png'),
                ),
              ),
              Text(
                'Psikologi',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );

    final tombolWatpres = Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.all(15),
        width: 50,
        color: Colors.greenAccent,
        child: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/watpres');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Image(
                  width: 90,
                  // color: Colors.red[600],
                  image: AssetImage('assets/images/004-newspaper.png'),
                ),
              ),
              Text(
                'Watpres',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );

    final tombolPanic = Expanded(
      flex: 3,
      child: Container(
          padding: EdgeInsets.all(15),
          width: 50,
          color: Colors.pink[600],
          child: FlatButton(
              onPressed: () {
                createDangerReport("8");

                final snackBar = SnackBar(
                  content: Text('Laporan Anda Telah Terkirim'),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the Scaffold in the widget tree and use
                // it to show a SnackBar.
                Scaffold.of(context).showSnackBar(snackBar);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Image(
                      width: 90,
                      image: AssetImage('assets/images/001-lifesaver.png'),
                    ),
                  ),
                  Text(
                    'Panic Button',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ))),
    );

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            // width: 150,
            color: Colors.white,
            child: Image.asset('assets/images/banner.png'),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                kotakLogo,
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        tombolDalper,
                        tombolBinkar,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Row(
              children: [
                tombolPsikologi,
                tombolWatpres,
                tombolPanic,
              ],
            ),
          ),
        ),
      ],
    );
    // kode asal
  }
}
