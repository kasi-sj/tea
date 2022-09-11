import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'fileuplode.dart';

class image extends StatefulWidget {
  const image({super.key});

  @override
  State<image> createState() => _imageState();
}

class _imageState extends State<image> {
  var some = '';
  var byte;
  var fileimage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(some),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 7,
            child: ListView(
              children: [
                if (fileimage != null)
                  Flexible(
                    child: Container(
                      child: Image.file(fileimage),
                    ),
                  ),
                Flexible(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                if (byte != null)
                  Flexible(
                    child: Container(
                      child: Image.memory(byte),
                    ),
                  ),
              ],
            ),
          ),
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
                        onPressed: () async {
                          final image = ImagePicker();
                          final XFile? pick = await image.pickImage(
                              source: ImageSource.gallery);

                          if (pick == null) return;
                          print(pick.path);

                          byte = await pick.readAsBytes();
                          print(byte);
                          setState(() {
                            fileimage = File(pick.path);
                            byte = byte;
                          });
                        },
                        child: Text('pick image'))),
              )),
          Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 115, 5, 240),
                    ),
                    height: 40,
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Uplode())));
                        },
                        child: Text('uplode page'))),
              )),
        ],
      ),
    );
  }
}
