import 'package:flutter/material.dart';
import 'people.dart';
import 'welcome.dart';
import 'package:vee/tracking.dart';

class Waiting extends StatefulWidget {
  const Waiting({super.key});
  static String id = "Waiting";

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  @override
  void initState() {
    super.initState();
    fun();
  }

  Future<dynamic> fun() async {
    {
      tracking som = tracking();
      String val = "";
      val = await som.readCounter();
      if (val == "") {
        Navigator.pushNamed(context, Welcome.id);
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return People(
            currentuser: val,
          );
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: CircularProgressIndicator()),
              Flexible(child: Text("wait ..")),
            ],
          ),
        ),
      ),
    );
  }
}

// TextButton(
//                   onPressed: () async {
//                     tracking som = tracking();
//                     String val = "";
//                     val = await som.readCounter();
//                     if (val == "") {
//                       Navigator.pushNamed(context, Welcome.id);
//                     } else {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return People(
//                           currentuser: val,
//                         );
//                       }));
//                     }
//                   },
//                   child: Text('press'))