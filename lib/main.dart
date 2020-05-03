import 'package:flutter/material.dart';
import 'package:fluttersliverhero/home_page.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
    );
  }
}
