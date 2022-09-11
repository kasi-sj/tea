import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/clickbutton.dart';
import 'dart:io';

class Writing extends StatefulWidget {
  @override
  State<Writing> createState() => _WritingState();
}

class _WritingState extends State<Writing> {
  String writtentext = '';
  String writtentext1 = '';

  var first = TextEditingController();

  bool spinner = false;

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<void> writeCounter(String counter) async {
    final file = await _localFile;

    // Write the file
    file.writeAsString(counter);
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return (contents);
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Container(
          color: Color.fromARGB(129, 193, 178, 198),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('images/2.png'),
                        child: Image(
                            height: 70, image: AssetImage('images/2.png'))),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        onChanged: ((value) {
                          writtentext1 = value;
                        }),
                        obscureText: false,
                        textAlign: TextAlign.center,
                        controller: first,
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          hintText: 'Enter Text',
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
                  ),
                  Flexible(
                    child: clickbutton(
                      color: Colors.cyan,
                      text: 'Enter data',
                      textcolor: Colors.white,
                      fun: () async {
                        setState(() {
                          first.clear();
                        });
                        await writeCounter(writtentext1);
                      },
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          title: Text(writtentext),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: clickbutton(
                      color: Colors.cyan,
                      text: 'Get data',
                      textcolor: Colors.white,
                      fun: () async {
                        final tex = await readCounter();
                        setState(() {
                          writtentext = tex;
                        });
                      },
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
