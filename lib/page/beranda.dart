import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'general_list.dart';
import '../utils/constants.dart';

class Beranda extends StatefulWidget {
  Beranda({Key key}) : super(key: key);
  static String tag = 'beranda';
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  var judul = 'Polda Kalbar';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> createDangerReport(BuildContext ctx) async {
    // buildShowDialog(ctx);
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext ctxy) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude.toString();
    var long = position.longitude.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mtoken = (prefs.getString('token') ?? '');

    debugPrint('Dapat lat: $lat long: $long token: $mtoken');
    final http.Response response = await http.post(
      Constants.apiUrl + 'panic',
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
      Navigator.of(ctx).pop();
      final snackBar = SnackBar(
        content: Text('Laporan Anda Telah Terkirim'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      throw Exception('Failed to create DangerReport.');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final tombolProfil = Container(
      padding: EdgeInsets.all(0),
      color: Colors.blueAccent.withOpacity(0.0),
      child: FlatButton(
        onPressed: () async {
          Navigator.pushNamed(context, '/profil');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Image(
                  width: 200,
                  // color: Colors.red[600],
                  image: AssetImage('assets/images/profil.png'),
                )),
            // Text(
            //   'Profil',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 12),
            // ),
          ],
        ),
      ),
    );
    final tombolDalper = Container(
      padding: EdgeInsets.all(0),
      color: Colors.blueGrey.withOpacity(0.0),
      child: FlatButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GeneralList('dalpers');
          }));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var _detoken = (prefs.getString('token') ?? '');
          debugPrint('Hasil token' + _detoken);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: Image(
                width: 200,
                // color: Colors.red[600],
                image: AssetImage('assets/images/dalpers.png'),
              ),
            ),
            // Text(
            //   'Dalper',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 12),
            // ),
          ],
        ),
      ),
    );
    final tombolBinkar = Container(
      padding: EdgeInsets.all(0),
      color: Colors.purple.withOpacity(0.0),
      child: FlatButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GeneralList('binkar');
          }));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: Image(
                width: 200,
                // color: Colors.red[600],
                image: AssetImage('assets/images/binkar.png'),
              ),
            ),
            // Text(
            //   'Binkar',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 12),
            // ),
          ],
        ),
      ),
    );
    final tombolPsikologi = Container(
      padding: EdgeInsets.all(0),
      width: 50,
      color: Colors.red.withOpacity(0.0),
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GeneralList('psikologi');
          }));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: Image(
                width: 200,
                // color: Colors.red[600],
                image: AssetImage('assets/images/psikologi.png'),
              ),
            ),
            // Text(
            //   'Psikologi',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 12),
            // ),
          ],
        ),
      ),
    );
    final tombolWatpres = Container(
      padding: EdgeInsets.all(0),
      width: 50,
      color: Colors.greenAccent.withOpacity(0.0),
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GeneralList('watpers');
          }));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: Image(
                width: 200,
                // color: Colors.red[600],
                image: AssetImage('assets/images/watpers.png'),
              ),
            ),
            // Text(
            //   'Watpres',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 12),
            // ),
          ],
        ),
      ),
    );
    final tombolYankes = Container(
      padding: EdgeInsets.all(0),
      color: Colors.blueGrey.withOpacity(0.0),
      child: FlatButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GeneralList('yankes');
          }));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Image(
                  width: 200,
                  // color: Colors.red[600],
                  image: AssetImage('assets/images/yankes.png'),
                )),
            // Text(
            //   'Yankes',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 12, color: Colors.white),
            // ),
          ],
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg-menu.jpg"),
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.only(top: 45.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            tombolProfil,
            tombolDalper,
            tombolBinkar,
            tombolWatpres,
            tombolPsikologi,
            tombolYankes,
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: FloatingActionButton(
          onPressed: () {
            createDangerReport(context);
          },
          child: Image(
            image: AssetImage('assets/images/sos.png'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
