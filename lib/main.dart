import 'package:flutter/material.dart';
import './page/binkar_list.dart';
import './page/dalper_list.dart';
import './page/psikologi_list.dart';
import './page/watpres_list.dart';
import './page/beranda.dart';
import './page/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LAPOR SDM',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      // initialRoute: '/',
      routes: {
        // '/': (context) => Beranda(),
        '/beranda': (context) => Beranda(),
        '/login-page': (context) => LoginPage(),
        '/dalper': (context) => DalperList(),
        '/binkar': (context) => BinkarList(),
        '/psikologi': (context) => PsikologiList(),
        '/watpres': (context) => WatpresList(),
      },
    );
  }
}
