import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Uplode extends StatefulWidget {
  const Uplode({super.key});

  @override
  State<Uplode> createState() => _UplodeState();
}

class _UplodeState extends State<Uplode> {
  String some = '';
  var bytes;
  var file;
  var filename;
  var task;
  UploadTask? uploadTask;

  UploadTask? uplode(String des, File fil) {
    try {
      final ref = FirebaseStorage.instance.ref(des);
      return ref.putFile(fil);
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> uplod() async {
    if (filename == null) return;
    final desti = 'files/$filename';
    task = uplode(desti, file);
    if (task == null) return;
    final snapshot = await task.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    setState(() {});

    print('downlodelink=$url');
  }

  Future<dynamic> func() async {
    final som = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (som == null) return;
    final path = som.files.single.path;
    file = File(path!);
    filename = basename(path);
    setState(() {
      some = filename;
    });
  }

  Widget progress(UploadTask tas) {
    return StreamBuilder<TaskSnapshot>(
      stream: tas.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          final process = (data!.bytesTransferred / data.totalBytes) * 100;
          if (process == 100.0) {
            Text('uploded succesfully');
          }
          return Text("uploading...$process%");
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(some),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 15,
              child: Center(child: ListTile(title: Center(child: Text(some))))),
          Flexible(
              flex: 5, child: task == null ? Container() : progress(task!)),
          Flexible(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 5, 240, 119),
                      ),
                      height: 40,
                      width: double.infinity,
                      child: TextButton(
                          child: Text(
                            'pick file',
                            style: TextStyle(color: Colors.indigo),
                          ),
                          onPressed: () async {
                            func();
                          })))),
          SizedBox(
            height: 40,
          ),
          Flexible(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 195, 112, 215),
                      ),
                      height: 40,
                      width: double.infinity,
                      child: TextButton(
                          child: Text('uplode file',
                              style: TextStyle(color: Colors.indigo)),
                          onPressed: () async {
                            uplod();
                          })))),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
