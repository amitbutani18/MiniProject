import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miniProject/Helpers/doctor_list_obj.dart';
import 'package:miniProject/Screens/chat.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorListObj doctorDetails;
  DoctorDetailsScreen({this.doctorDetails});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              sendMessage(doctorDetails.personalDetails.uid, context),
          child: Icon(Icons.chat),
        ),
        body: Center(
          child: Container(
            child: Text(doctorDetails.profesionalDetails.regNumber),
          ),
        ));
  }

  sendMessage(String userId, BuildContext context) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    final myUid = pre.getString('uid');
    List<String> users = [myUid, userId];

    final userName = await http.get(
        'https://miniproject-dc6b4.firebaseio.com/$myUid/profile/fullName.json');
    print(json.decode(userName.body));
    print(myUid);
    print(userId);

    String chatRoomId = getChatRoomId(myUid, userId);

    Map<String, dynamic> chatRoom = {
      "userName": json.decode(userName.body),
      "users": users,
      "chatRoomId": chatRoomId,
    };
    addChatRoom(chatRoom, chatRoomId);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                  myUid: myUid,
                )));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }
// }
}
