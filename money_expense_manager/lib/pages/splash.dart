// not just splash , will ask use for their name here

import 'package:expense/controllers/db_helper.dart';
import 'package:expense/pages/add_name.dart';
import 'package:expense/pages/homepage.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  //
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    getName();
  }

  Future getName() async {
    String? name = await dbHelper.getName();
    if (name != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Homepage(),
          ),
        );
      }
     else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AddName(),
        ),
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      // backgroundColor: Color(0xffe2e7ef),
      //
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          padding: EdgeInsets.all(
            16.0,
          ),
          child: Image.asset(
            "assets/icon.png",
            width: 64.0,
            height: 64.0,

          ),


        ),

      ),

    );
  }
}
