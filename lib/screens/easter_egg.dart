import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasterEgg extends StatelessWidget {
  const EasterEgg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            'Easter Egg',
            style: TextStyle(color: Colors.grey[900]),
          ),
        ),
        body: Center(
            child: Image.asset('images/birthdaycat.png'),
        ));
  }
}
