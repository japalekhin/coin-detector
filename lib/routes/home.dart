import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mint'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Oh yeah'),
          ),
        ],
      ),
    );
  }
}
