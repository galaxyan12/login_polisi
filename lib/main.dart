import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Polisi',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'), fit: BoxFit.cover)),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 45.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Image.asset('assets/text_A.png'),
                SizedBox(
                  height: 8,
                ),
                Image.asset('assets/text_b.png')
              ],
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              autofocus: false,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.orangeAccent,
                  labelText: "NRP",
                  labelStyle: TextStyle(fontSize: 14, color: Colors.white)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              autofocus: false,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.orangeAccent,
                  labelText: "Password",
                  labelStyle: TextStyle(fontSize: 14, color: Colors.white)),
              obscureText: true,
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  height: 40,
                  disabledColor: Colors.orangeAccent,
                  child: RaisedButton(
                    onPressed: null,
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Nasalization',
                          color: Colors.red),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/pak_polisi3.png',
              height: 230,
              width: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/logo_lapor.png',
                  height: 50,
                  width: 50,
                ),
                Image.asset(
                  'assets/logo_polri.png',
                  height: 100,
                  width: 100,
                ),
                Image.asset(
                  'assets/logo_sdm.png',
                  height: 50,
                  width: 50,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
