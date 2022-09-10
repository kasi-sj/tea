import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Play extends StatefulWidget {
  const Play({Key? key}) : super(key: key);

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  var byte;
  var fileimage;
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
                      "https://th.bing.com/th/id/OIP.Ix6XjMbuCvoq3EQNgJoyEQHaFj?pid=ImgDet&rs=1",
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
                  if (fileimage != null)
                    Container(
                      child: Image.file(fileimage),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  if (byte != null)
                    Container(
                      child: Image.memory(byte),
                    ),
                ],
              ),
            ),
            Flexible(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  height: 30,
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () async {
                        final image = ImagePicker();
                        final XFile? pick =
                            await image.pickImage(source: ImageSource.gallery);
                        print('hi');

                        if (pick == null) return;
                        print(pick.path);

                        byte = await pick.readAsBytes();
                        print(byte);
                        setState(() {
                          fileimage = File(pick.path);
                          byte = byte;
                        });
                      },
                      child: Text('press'))),
            ))
          ],
        ),
      ),
    );
  }
}
