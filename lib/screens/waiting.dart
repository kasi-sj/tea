import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'people.dart';
import 'welcome.dart';
import 'package:vee/tracking.dart';
import 'package:vee/core.dart';

class Waiting extends StatefulWidget {
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
      print("");
      print("Instantiating...");
      final platform = PlatformCore();
      print("");
      print("Successfull");
      if (val == "") {
        Navigator.pushNamed(context, Welcome.id);
      } else {
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return People(
            currentuser: val,
          );
        }));
        Navigator.pop(context);
        SystemNavigator.pop();
        fun();
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
