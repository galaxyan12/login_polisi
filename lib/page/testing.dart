import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  Testing({Key key}) : super(key: key);
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Saya'),
      ),
      body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: [
            Container(
              margin: EdgeInsets.all(20),
              color: Colors.red,
              child: Center(
                child: Text(
                  'Beranda',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              color: Colors.green,
              child: Center(
                child: Text(
                  'Satu',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Logout',
          ),
        ],
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        // onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
