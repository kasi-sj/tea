import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:vee/screens/play1.dart';
import 'package:vee/screens/login.dart';
import 'package:vee/screens/play.dart';
import '../widgets/clickbutton.dart';
import 'package:vee/screens/press.dart';
import 'Register.dart';

class Welcome extends StatelessWidget {
  static String id = 'welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(173, 90, 131, 144),
        child: Center(
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
                clickbutton(
                    color: Colors.green,
                    text: 'play',
                    textcolor: Colors.white,
                    fun: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Play())));
                    }),
                clickbutton(
                    color: Colors.green,
                    text: 'play1',
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
                    color: Colors.green,
                    text: 'press1',
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
              ]),
        ),
      ),
    );
  }
}
