import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vee/widgets/bottomadd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'follow.dart';
import 'request.dart';
import 'package:vee/screens/chat.dart';
import 'more_option.dart';
import 'package:vee/profiletracking.dart';

import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'fileuplode.dart';
import 'image.dart';
import 'dart:io';

class People extends StatefulWidget {
  int following = 0;
  int followers = 0;
  static String id = 'people screen';
  String currentuser;
  People({required this.currentuser});

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  FirebaseFirestore _friend = FirebaseFirestore.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String some = '';
  var bytes;
  var file;
  var filename = '';
  var filepath = '';
  var task;
  var somet = '';
  var byte;
  var fileimage;

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

  Future<dynamic> uplod(String path) async {
    if (filename == null) return;
    final desti = 'profile/${widget.currentuser}';
    print('uploading');
    task = uplode(desti, file);
    if (task == null) return;
    final snapshot = await task.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    await firestore
        .collection(widget.currentuser)
        .doc('profile')
        .set({'url': url});
    tracking track = tracking();
    track.writeCounter(path);
    file = File(path);
    filename = basename(path);
    filepath = path;

    setState(() {});

    print('downlodelink=$url');
  }

  imagesup() async {
    final image = ImagePicker();
    final XFile? pick = await image.pickImage(source: ImageSource.gallery);

    if (pick == null) return;

    setState(() {
      file = File(pick.path);
      filename = basename(pick.path);
    });

    uplod(pick.path);
  }

  void addli(var val) async {
    if ((val != widget.currentuser) &&
        (await hasfriend(val)) &&
        (await hasrequest(val)) &&
        (await hasusers(val))) {
      try {
        var ide = await _friend.collection(val.toString()).add(
            {'request': widget.currentuser, 'id1': '', 'id2': '', 'id3': ''});
        var id = await _friend
            .collection(widget.currentuser.toString())
            .add({'friend': val, 'status': 'not yet', 'key': ''});
        var id1 = id.id;

        var id2 = ide.id;
        var ida = await _friend
            .collection(widget.currentuser.toString())
            .add({'follow': val.toString(), 'id1': '', 'id2': '', 'id3': ''});
        var id3 = ida.id;

        await _friend.collection(val.toString()).doc(id2.toString()).update({
          'id1': id1.toString(),
          'id2': id2.toString(),
          'id3': id3.toString()
        });

        await _friend
            .collection(widget.currentuser.toString())
            .doc(id3.toString())
            .update(({
              'id1': id1.toString(),
              'id2': id2.toString(),
              'id3': id3.toString()
            }));
      } catch (e) {
        print(e);
      }
    } else {
      print('error');
    }
  }

  hasfriend(var valu) async {
    List list = await getfriend();
    if (list.isNotEmpty) {
      for (var i in list) {
        if (i == valu) {
          return false;
        }
      }
      return true;
    }
    return true;
  }

  hasrequest(var valu) async {
    List list = await getrequest();
    if (list.isNotEmpty) {
      for (var i in list) {
        if (i == valu) {
          return false;
        }
      }
      return true;
    }
    return true;
  }

  hasusers(var valu) async {
    String stat = await getusers(valu);
    if (stat == 'ok') {
      {
        return true;
      }
    }
    return false;
  }

  Future getfriend() async {
    List<String> friend = [];
    try {
      await for (var Snapshot
          in firestore.collection(widget.currentuser.toString()).snapshots()) {
        for (var message in Snapshot.docs) {
          try {
            if (message.get('status') == 'ok') {
              friend.add(message.get('friend'));
            }
          } catch (e) {
            print(e);
          }
        }
        friend = friend.toSet().toList();
        return friend;
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future getfollow() async {
    List<String> friend = [];
    try {
      await for (var Snapshot
          in firestore.collection(widget.currentuser.toString()).snapshots()) {
        for (var message in Snapshot.docs) {
          try {
            if (message.get('status') == 'not yet') {
              friend.add(message.get('friend'));
            }
          } catch (e) {
            print(e);
          }
        }
        friend = friend.toSet().toList();
        return friend;
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future getrequest() async {
    List<String> request = [];
    try {
      await for (var Snapshot
          in firestore.collection(widget.currentuser.toString()).snapshots()) {
        for (var message in Snapshot.docs) {
          try {
            request.add(message.get('request'));
          } catch (e) {
            print(e);
          }
        }

        request = request.toSet().toList();

        return request;
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  getfollowers() async {
    List list = [];
    list = await getrequest();
    widget.followers = list.length;
  }

  getfollowing() async {
    List list = [];
    list = await getfollow();
    widget.following = list.length;
  }

  Future getusers(String val) async {
    var users;
    try {
      users = await firestore.collection('user').doc(val.toString()).get();
      print(users['users']);
      return users['users'];
    } catch (e) {
      users = '';
      return users;
    }
  }

  gettingfile() async {
    tracking track = tracking();
    var gett = await track.readCounter();
    file = File(gett);
    filename = basename(gett);
    filepath = gett;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfollowers();
    getfollowing();
    gettingfile();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade500,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  imagesup();
                },
                child: CircleAvatar(
                    radius: 15,
                    child: ClipOval(
                      child: filename == ''
                          ? Image(image: AssetImage('images/smile.png'))
                          : Image.file(file),
                    )),
              ),
              // ignore: prefer_const_constructors
              Row(
                children: [
                  TextButton(
                      onPressed: (() {
                        getfollowing();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Follow(
                            currentuser: widget.currentuser,
                            following: widget.following,
                          );
                        }));
                      }),
                      child: Column(
                        children: [
                          Icon(
                            Icons.people,
                            color: Colors.greenAccent,
                          ),
                          Text('following')
                        ],
                      )),
                  TextButton(
                      onPressed: (() {
                        getfollowers();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Request(
                            currentuser: widget.currentuser,
                            followers: widget.followers,
                          );
                        }));
                      }),
                      child: Column(
                        children: [
                          Icon(
                            FontAwesomeIcons.heart,
                            color: Colors.lightGreenAccent,
                          ),
                          Text('followers')
                        ],
                      )),
                  TextButton(
                      onPressed: (() {
                        getfollowing();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Moreoption();
                        }));
                      }),
                      child: Column(
                        children: [
                          Icon(
                            Icons.more_horiz_outlined,
                            color: Colors.greenAccent,
                          ),
                          Text('more')
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 7, 189, 230),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestore
                  .collection(widget.currentuser.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: SpinKitCircle(
                    color: Colors.grey,
                  ));
                }
                var message = snapshot.data!;
                List<people> lis = [];
                for (var mes in message.docs.reversed) {
                  try {
                    if (mes.get('status') == 'ok') {
                      var text = mes.get('friend');
                      var key = mes.get('key');
                      var info = people(
                        text: text,
                        keys: key,
                        user: widget.currentuser,
                      );
                      lis.add(info);
                    }
                  } catch (e) {
                    print(e);
                  }
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(
                      children: lis,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 20, 199, 29),
        onPressed: () {
          getfollowers();
          getfollowing();
          getrequest();
          getfriend();
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Bottomadd(
                  fun: (value) {
                    addli(value);
                  },
                );
              });
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}

class people extends StatelessWidget {
  people({required this.text, required this.keys, required this.user});
  var text = '';
  var keys = '';
  var user = '';

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Chat(username: user, keys: keys.toString());
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: ListTile(
            title: Text(text),
          ),
        ),
      ),
    );
  }
}
