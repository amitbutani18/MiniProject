import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:miniProject/Helpers/doctor_list_obj.dart';
import 'package:miniProject/Helpers/notice_list.dart';
import 'package:miniProject/Screens/chat.dart';
import 'package:miniProject/Screens/scheduleing_screen.dart';
import 'package:miniProject/Screens/utils/constants.dart';
import 'package:miniProject/Screens/utils/d_colors.dart';
import 'package:miniProject/Screens/utils/dashbord_widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:rating_dialog/rating_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorListObj doctorDetails;
  DoctorDetailsScreen({this.doctorDetails});
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       floatingActionButton: FloatingActionButton(
  //         onPressed: () =>
  //             sendMessage(doctorDetails.personalDetails.uid, context),
  //         child: Icon(Icons.chat),
  //       ),
  //       body: Center(
  //         child: Container(
  //           child: Text(doctorDetails.profesionalDetails.regNumber),
  //         ),
  //       ));
  // }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(color: d_blue),
        IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  void _showRatingDialog(BuildContext context) {
    // We use the built in showDialog function to show our Rating Dialog
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: const FlutterLogo(
              size: 100,
            ), // set your own image/icon widget
            title: "Please give a rating",
            description:
                "Tap a star to set your rating. Add more description here if you want.",
            submitButton: "SUBMIT",
            alternativeButton: "Contact us instead?", // optional
            positiveComment: "We are so happy to hear :)", // optional
            negativeComment: "We're sad to hear :(", // optional
            accentColor: Colors.indigoAccent, // optional
            onSubmitPressed: (int rating) {
              print("onSubmitPressed: rating = $rating");
              // TODO: open the app's page on Google Play / Apple App Store
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
              // TODO: maybe you want the user to contact you instead of rating a bad review
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<String> text = [
      "APPOINTMENT",
      "PRICE",
      "PERSONAL",
      "PROFESIONAL",
    ];

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   actions: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: <Widget>[
      //         BackButton(color: Theme.of(context).primaryColor),
      //         IconButton(
      //           icon: Icon(
      //             Icons.search,
      //           ),
      //           onPressed: null,
      //         ),
      //       ],
      //     )
      //   ],
      // ),
      backgroundColor: d_colorPrimary.withOpacity(.8),
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(
            //   height: 20,
            // ),
            _appbar(),
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 50, left: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.phone_in_talk,
                    //   ),
                    //   onPressed: null,
                    // ),
                    Container(
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () async {
                          const url = 'tel:+919913089071';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'could not launch $url';
                          }
                        },
                        child: Icon(
                          Icons.phone_in_talk,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: d_blue),
                        image: DecorationImage(
                            image: NetworkImage(
                              doctorDetails.personalDetails.imageUrl,
                            ),
                            fit: BoxFit.cover),
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () => sendMessage(
                            doctorDetails.personalDetails.uid,
                            context,
                            doctorDetails.personalDetails.name),
                        child: Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              doctorDetails.personalDetails.name,
              style: TextStyle(
                fontSize: textSizeLarge,
                fontFamily: fontBold,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LimitedBox(
                  maxWidth: width,
                  maxHeight: 20,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => Text(
                            doctorDetails.profesionalDetails.qulifications[i] +
                                ', ',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                      itemCount: doctorDetails
                          .profesionalDetails.qulifications.length),
                ),
              ],
            ),
            // Text(
            //   doctorDetails.profesionalDetails.qulifications[0],
            //   style: TextStyle(
            //     fontSize: textSizeSmall,
            //     fontFamily: fontBold,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.grey,
            //   ),
            // ),
            // Text(
            //   "smeet vaghani",
            //   style: TextStyle(
            //     fontSize: textSizeSmall,
            //     fontFamily: fontBold,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.grey,
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 250,
              child: RaisedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, 'razorpay');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ScheduleingScreen(personalDetails: doctorDetails)));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  // side: BorderSide(),
                ),
                color: d_blue,
                child: Text(
                  "BOOK APPOINTMENT",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 10, 18, 0),
                child: AnimationLimiter(
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: gridItemslist.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: customCardlist(
                            index,
                            height,
                            width,
                            gridItemslist[index],
                            context,
                          ),
                        );
                      }),
                ),
              ),
            ),
            // Container(
            //   height: 400,
            //   child: GridView.count(
            //     // scrollDirection: Axis.horizontal,
            //     crossAxisCount: 2,
            //     children: List.generate(
            //       4,
            //       (index) {
            //         return Container(
            //           child: Card(
            //             // color: Colors.amber,
            //             child: Center(
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Icon(
            //                     Icons.date_range,
            //                   ),
            //                   SizedBox(
            //                     height: 10,
            //                   ),
            //                   Text("${text[index]}"),
            //                   Text("DETAILS")
            //                 ],
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

//   AnimationConfiguration customCard(int index, double height, double width,
//     GridItem gridItem, BuildContext context) {
//   return AnimationConfiguration.staggeredGrid(
//     columnCount: 3,
//     position: index,
//     duration: const Duration(milliseconds: 400),
//     child: ScaleAnimation(
//       child: FadeInAnimation(
//         child: new GestureDetector(
//           child: new Container(
//             decoration: BoxDecoration(
//                 color: d_app_background,
//                 borderRadius: BorderRadius.circular(15)),
//             alignment: Alignment.center,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: height / 20,
//                   width: width / 13,
//                   child: Image.network(gridItem.image),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 text(
//                   gridItem.title,
//                   textColor: d_textColorPrimary.withOpacity(.8),
//                   fontSize: textSizeSmall,
//                   fontFamily: fontMedium,
//                 ),
//               ],
//             ),
//           ),
//           onTap: () {
//             Navigator.of(context).pushNamed(gridItem.tag);
//           },
//         ),
//       ),
//     ),
//   );
// }

  AnimationConfiguration customCardlist(int index, double height, double width,
      GridItemlist gridItemslist, BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: 3,
      position: index,
      duration: const Duration(milliseconds: 400),
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: d_app_background,
                  borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height / 20,
                    width: width / 13,
                    child: Image.network(gridItemslist.image),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  text(
                    gridItemslist.title,
                    textColor: d_textColorPrimary.withOpacity(.8),
                    fontSize: textSizeSmall,
                    fontFamily: fontMedium,
                  ),
                ],
              ),
            ),
            onTap: () => _showRatingDialog(context),
          ),
        ),
      ),
    );
  }

  sendMessage(String userId, BuildContext context, String name) async {
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
          name: name,
        ),
      ),
    );
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
