import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/clickbutton.dart';
import '../screens/people.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  static String id = 'Register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var first = TextEditingController();

  var second = TextEditingController();
  bool spinner = false;

  String user = '';

  String password = '';

  FirebaseAuth register = FirebaseAuth.instance;

  FirebaseFirestore users = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Container(
          color: Colors.deepPurpleAccent.shade100,
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
                      controller: second,
                      onChanged: (value) {
                        user = value;
                      },
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
                      controller: first,
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
                    text: 'REGISTER',
                    textcolor: Colors.white,
                    fun: () async {
                      try {
                        setState(() {
                          first.clear();
                          second.clear();

                          spinner = true;
                        });
                        final newer =
                            await register.createUserWithEmailAndPassword(
                                email: user, password: password);

                        if (newer != null) {
                          users.collection('user').add({'users': user});

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return People(currentuser: user);
                          }));
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
