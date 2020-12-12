import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miniProject/Screens/utils/database.dart';
import 'package:miniProject/providers/join.dart';

class Chat extends StatefulWidget {
  final String chatRoomId, myUid, name;

  Chat({this.chatRoomId, this.myUid, this.name});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        // print(snapshot.data.documents[0]['message']);
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.documents[index]["message"],
                    sendByMe: widget.myUid ==
                        snapshot.data.documents[index]["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": widget.myUid,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  Widget appBarMain(BuildContext context) {
    return AppBar(
      title: Text(
        widget.name,
        // height: 40,
      ),
      elevation: 0.0,
      centerTitle: false,
      actions: [
        GestureDetector(
          onTap: onJoin,
          child: Image.asset(
            "assets/img/video_call.png",
             width: 30, height: 30
          ),
        ),
        SizedBox(width: 15,)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: chatMessages(),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              height: 61,
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: messageEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(18),
                                hintText: "Type Something...",
                                hintStyle: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onTap: () {
                        addMessage();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    // setState(() {
    //   _channelController.text.isEmpty
    //       ? _validateError = true
    //       : _validateError = false;
    // });
    // if (_channelController.text.isNotEmpty) {
    // await for camera and mic permissions before pushing video page
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JoinPage(),
      ),
    );
    // }
  }
}
//     return Scaffold(
//       backgroundColor: Colors.black45,
//       appBar: appBarMain(context),
//       body: Container(
//         child: Stack(
//           children: [
//             chatMessages(),
//             Container(
//               alignment: Alignment.bottomCenter,
//               width: MediaQuery.of(context).size.width,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//                 color: Color(0x54FFFFFF),
//                 child: Row(
//                   children: [
//                     Expanded(
//                         child: TextField(
//                       controller: messageEditingController,
//                       // style: simpleTextStyle(),
//                       decoration: InputDecoration(
//                           hintText: "Message ...",
//                           hintStyle: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                           border: InputBorder.none),
//                     )),
//                     SizedBox(
//                       width: 16,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         addMessage();
//                       },
//                       child: Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   colors: [
//                                     const Color(0x36FFFFFF),
//                                     const Color(0x0FFFFFFF)
//                                   ],
//                                   begin: FractionalOffset.topLeft,
//                                   end: FractionalOffset.bottomRight),
//                               borderRadius: BorderRadius.circular(40)),
//                           padding: EdgeInsets.all(12),
//                           child: Icon(
//                             Icons.send,
//                             // height: 25,
//                             // width: 25,
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: sendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
          gradient: LinearGradient(
            // colors: [const Color(0xff007EF4), const Color(0xff2A75BC)],
            colors: sendByMe
                ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                : [
                    Color(0xFF6270DD),
                    Color(0xFF6270DD).withOpacity(.7),
                  ],
          ),
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
