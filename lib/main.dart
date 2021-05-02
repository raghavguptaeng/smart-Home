import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Screens/home.dart';
import 'constants.dart';

void main() {
  runApp(init());
}

class init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainBody(),
    );
  }
}
