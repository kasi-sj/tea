import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'fileuplode.dart';
import 'image.dart';

class Play extends StatefulWidget {
  const Play({Key? key}) : super(key: key);

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('play here'),
      ),
      backgroundColor: Colors.green,
      body: Container(
        child: Column(
          children: [
            Flexible(
              flex: 8,
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Image.network(
                      "https://media.istockphoto.com/vectors/artificial-intelligence-concept-vector-id950131318?k=6&m=950131318&s=612x612&w=0&h=RE73KdAf4ppnsy51sRk7uuZRrqrJIpM4C2CpF8IMfkI=",
                      loadingBuilder: ((context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : Container(
                                  child: CircularProgressIndicator(),
                                )),
                      height: 400,
                      width: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.blue,
                    child: Image(image: AssetImage('images/2.png')),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: AssetImage('images/2.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                      radius: 90,
                      child: ClipOval(
                        child: Image(image: AssetImage('images/happy.png')),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                      radius: 90,
                      child: ClipOval(
                        child: Image(image: AssetImage('images/smile.png')),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                      radius: 90,
                      child: ClipOval(
                        child: Image(image: AssetImage('images/cry.png')),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                      radius: 90,
                      child: ClipOval(
                        child: Image(image: AssetImage('images/anger.png')),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => image())),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.pink),
                    child: ListTile(
                      title: Center(child: Text('image view')),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
