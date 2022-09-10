import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/clickbutton.dart';
import '../screens/people.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  static String id = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = '';

  String password = '';

  FirebaseAuth login = FirebaseAuth.instance;

  var first = TextEditingController();

  var second = TextEditingController();

  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Container(
          color: Color.fromARGB(129, 142, 95, 143),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: ((value) {
                        username = value;
                      }),
                      obscureText: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        filled: true,
                        fillColor: Colors.white60,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green.shade400, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green.shade400, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        filled: true,
                        fillColor: Colors.white60,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green.shade400, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green.shade400, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                  clickbutton(
                    color: Colors.cyan,
                    text: 'LOGIN',
                    textcolor: Colors.white,
                    fun: () async {
                      try {
                        setState(() {
                          first.clear();
                          second.clear();

                          spinner = true;
                        });
                        final user = await login.signInWithEmailAndPassword(
                            email: username, password: password);
                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      People(currentuser: username))));
                        }
                        setState(() {
                          spinner = false;
                        });
                      } catch (e) {
                        print(e);

                        setState(() {
                          spinner = false;
                        });
                      }
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
