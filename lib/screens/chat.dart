import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vee/constant.dart';

var textfielder = TextEditingController();

class Chat extends StatefulWidget {
  String username;
  String keys;
  Chat({required this.username, required this.keys});
  static const id = 'chat';
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late String message;
  messagestreme() async {
    await for (var Snapshot
        in firestore.collection(widget.keys.toString()).snapshots()) {
      for (var message in Snapshot.docs) {
        print(message.data());
      }
    }
  }

  var currentuser;
  void getcurrentuser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      currentuser = user.email;
      print(currentuser);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.close), onPressed: () {}),
        ],
        title: Text('vee Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 33, 180, 196),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: firestore
                    .collection(widget.keys)
                    .orderBy('time', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: SpinKitCircle(
                      color: Colors.grey,
                    ));
                  }
                  var message = snapshot.data!;
                  List<Padding> lis = [];
                  for (var mes in message.docs.reversed) {
                    var text = mes.get('text');
                    var user = mes.get('sender');
                    var time = mes.get('time');
                    bool val = user == currentuser ? true : false;
                    var info = Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: messagebox(
                        user: user,
                        text: text,
                        tim: time,
                        value: val,
                      ),
                    );
                    lis.add(info);
                  }
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        reverse: true,
                        children: lis,
                      ),
                    ),
                  );
                },
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          message = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                        controller: textfielder,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          textfielder.clear();
                        });

                        firestore.collection(widget.keys).add({
                          'text': message,
                          'time': FieldValue.serverTimestamp(),
                          'sender': currentuser
                        });
                      },
                      child: Row(
                        children: [Icon(FontAwesomeIcons.paperPlane)],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class messagebox extends StatelessWidget {
  messagebox(
      {Key? key,
      required this.user,
      required this.text,
      required this.tim,
      required this.value})
      : super(key: key);

  final String user;
  final String text;
  final bool value;
  var tim;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          value ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: value ? Radius.circular(10) : Radius.zero,
                topRight: !value ? Radius.circular(10) : Radius.zero),
            color: value ? Colors.blueAccent : Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              text,
              style: TextStyle(
                  color: value ? Colors.white : Colors.black87, fontSize: 20),
            ),
          ),
        )
      ],
    );
  }
}
