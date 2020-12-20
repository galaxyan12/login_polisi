import 'package:flutter/material.dart';
import './page/beranda.dart';
import './page/profil.dart';
import './page/login_page.dart';
import './utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String _detoken = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _detoken = (prefs.getString('token') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (_detoken != '') ? Beranda() : LoginPage(),
      // initialRoute: '/',
      routes: {
        // '/': (context) => Beranda(),
        '/beranda': (context) => Beranda(),
        '/login-page': (context) => LoginPage(),
        '/profil': (context) => Profil(),
      },
    );
  }
}
