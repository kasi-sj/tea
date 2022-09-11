import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:vee/screens/play1.dart';
import 'package:vee/screens/login.dart';
import 'package:vee/screens/play.dart';
import '../widgets/clickbutton.dart';
import 'package:vee/screens/press.dart';
import 'package:vee/screens/more_option.dart';

import 'Register.dart';

class Welcome extends StatelessWidget {
  static String id = 'welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(173, 90, 131, 144),
        child: Center(
          child: Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/2.png'),
                      child:
                          Image(height: 70, image: AssetImage('images/2.png'))),
                  clickbutton(
                    color: Colors.cyan,
                    text: 'LOGIN',
                    textcolor: Colors.white,
                    fun: () {
                      Navigator.pushNamed(context, Login.id);
                    },
                  ),
                  clickbutton(
                    color: Color.fromARGB(255, 13, 100, 166),
                    text: 'REGISTER',
                    textcolor: Colors.white,
                    fun: () {
                      Navigator.pushNamed(context, Register.id);
                    },
                  ),
                ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => Moreoption())));
        },
        child: Icon(Icons.more),
      ),
    );
  }
}
