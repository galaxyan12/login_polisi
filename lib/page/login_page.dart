import '../models/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  String _token = '';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nrpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<Login> _futureLogin;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<Login> doLogin(String nrp, String password) async {
    final http.Response response = await http.post(
      'http://sdmpolda.kawansaye.net/api/login',
      body: {
        'nrp': nrp,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      _saveToken(json['token']);
      debugPrint(json['token']);
      return Login.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login.');
    }
  }

  //Loading counter value on start
  _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = (prefs.getString('token') ?? '');
    });
  }

  //Incrementing counter after click
  _saveToken(tokenValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', tokenValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/logoapp.png'),
      ),
    );

    final nrpField = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Masukkan NRP';
        }
        return null;
      },
      controller: _nrpController,
      keyboardType: TextInputType.number,
      autofocus: false,
      // initialValue: 'alucard@gmail.com',
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'NRP',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Masukkan Password';
        }
        return null;
      },
      controller: _passwordController,
      autofocus: false,
      // initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = RaisedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          Navigator.pushNamed(context, '/beranda');
          _futureLogin = doLogin(_nrpController.text, _passwordController.text);
        }
      },
      child: Text('Masuk'),
      color: Colors.lightBlue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.grey)),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Lupa password?',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                SizedBox(height: 48.0),
                nrpField,
                SizedBox(height: 8.0),
                password,
                SizedBox(height: 24.0),
                loginButton,
                forgotLabel
              ],
            ),
          ),
        ),
      ),
    );
  }
}
