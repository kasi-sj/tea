import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Follow extends StatefulWidget {
  static String id = 'Follow screen';
  int following;
  String currentuser;
  Follow({required this.currentuser, required this.following});

  @override
  State<Follow> createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> request = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo.shade500,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Following'), Text(widget.following.toString())],
          )),
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
                    var text = mes.get('follow');
                    var id1 = mes.get('id1');
                    var id2 = mes.get('id2');
                    var id3 = mes.get('id3');
                    var info = people(
                      id1: id1,
                      id2: id2,
                      id3: id3,
                      text: text,
                      user: widget.currentuser,
                    );
                    lis.add(info);
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
    );
  }
}

class people extends StatelessWidget {
  people(
      {required this.text,
      required this.user,
      required this.id1,
      required this.id2,
      required this.id3});
  var id1;
  var id2;
  var id3;
  var text = '';
  String user;

  FirebaseFirestore friend = FirebaseFirestore.instance;

  void remli(var val) async {
    try {
      await friend.collection(val.toString()).doc(id2.toString()).delete();

      await friend.collection(user.toString()).doc(id3.toString()).delete();

      await friend.collection(user.toString()).doc(id1.toString()).delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(text),
            ),
            TextButton.icon(
                onPressed: () {
                  remli(text);
                },
                icon: Icon(FontAwesomeIcons.minus),
                label: Text('remove'))
          ],
        ),
      ),
    );
  }
}
