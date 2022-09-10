import 'package:flutter/material.dart';

class Bottomadd extends StatelessWidget {
  var control = TextEditingController();
  Function fun;
  String newvalue = '';
  Bottomadd({required this.fun});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: Color.fromARGB(0, 124, 119, 119),
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 221, 218, 215),
                borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(
                      child: const Text(
                    'Add friend',
                    style: TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 12, 13, 14)),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: control,
                    onChanged: (value) {
                      newvalue = value;
                    },
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      hintText: 'Enter mail id',
                      filled: true,
                      fillColor: Colors.white60,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green.shade400, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green.shade400, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green.shade400,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                          onPressed: () {
                            control.clear();
                            fun(newvalue);

                            Navigator.pop(context);
                          },
                          child: const Text(
                            'ADD',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
