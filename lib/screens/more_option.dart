import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:vee/screens/play1.dart';
import 'package:vee/screens/login.dart';
import 'package:vee/screens/play.dart';
import 'package:vee/screens/welcome.dart';
import 'package:vee/screens/writing.dart';
import '../widgets/clickbutton.dart';
import 'package:vee/screens/press.dart';
import 'Register.dart';

class Moreoption extends StatelessWidget {
  static String id = 'welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('more option'),
        ),
        body: Container(
          height: double.infinity,
          color: Color.fromARGB(173, 90, 131, 144),
          child: ListView(
            children: [
              Center(
                child: Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('images/2.png'),
                            child: Image(
                                height: 70, image: AssetImage('images/2.png'))),
                        clickbutton(
                            color: Colors.green,
                            text: 'play',
                            textcolor: Colors.white,
                            fun: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Play())));
                            }),
                        clickbutton(
                            color: Color.fromARGB(255, 30, 121, 142),
                            text: 'camara',
                            textcolor: Colors.white,
                            fun: () async {
                              WidgetsFlutterBinding.ensureInitialized();

                              final cameras = await availableCameras();

                              final firstCamera = cameras.first;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Play1(
                                            firstCamera: firstCamera,
                                            cameras: cameras,
                                          ))));
                            }),
                        clickbutton(
                            color: Color.fromARGB(255, 194, 207, 51),
                            text: 'connection',
                            textcolor: Colors.white,
                            fun: () async {
                              WidgetsFlutterBinding.ensureInitialized();

                              final cameras = await availableCameras();

                              final firstCamera = cameras.firstWhere(
                                  (CameraDescription) =>
                                      CameraDescription.lensDirection ==
                                      CameraLensDirection.front);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Press1(
                                            firstCamera: firstCamera,
                                            cameras: cameras,
                                          ))));
                            }),
                        clickbutton(
                            color: Color.fromARGB(255, 153, 153, 147),
                            text: 'writing',
                            textcolor: Colors.white,
                            fun: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Writing();
                              }));
                            }),
                        clickbutton(
                            color: Color.fromARGB(255, 153, 153, 147),
                            text: 'welcome',
                            textcolor: Colors.white,
                            fun: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Welcome();
                              }));
                            }),
                      ]),
                ),
              ),
            ],
          ),
        ));
  }
}
