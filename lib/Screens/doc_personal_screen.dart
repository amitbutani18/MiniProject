import 'package:flutter/material.dart';
import 'package:miniProject/Helpers/doctor_list_obj.dart';
import 'package:miniProject/Screens/utils/d_colors.dart';

class DocPersonal extends StatefulWidget {
  static const routeName = 'appointment';
  @override
  _DocPersonalState createState() => _DocPersonalState();
}

class _DocPersonalState extends State<DocPersonal> {

  
PersonalDetails personalDetails;
  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(color: Theme.of(context).primaryColor),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg =  ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    personalDetails = arg['doctorPersonalDetails'];
    print(personalDetails.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Image.asset('assets/img/doc_profile.png'),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: MediaQuery.of(context).size.height * .5,
                  padding: EdgeInsets.only(
                      left: 19,
                      right: 19,
                      top: 16), //symmetric(horizontal: 19, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                personalDetails.name,
                                // style: titleStyle,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.check_circle,
                                  size: 18,
                                  color: Theme.of(context).primaryColor),
                              Spacer(),
                              
                              // RatingStar(
                              //   rating: 4.5,
                              // )
                            ],
                          ),
                          
                        ),
                        Divider(
                          thickness: .3,
                          // color: LightColor.grey,
                        ),
                        Divider(
                          thickness: .3,
                          color: Color(0xffb8bfce),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Father Name",
                            // style: titleStyle,
                          ),
                        ),
                        Text(
                          personalDetails.fatherName,
                          style: TextStyle(
                            color: Color(0xffb9bfcd),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Address",
                            // style: titleStyle,
                          ),
                        ),
                        Text(
                          personalDetails.address,
                          style: TextStyle(
                            color: Color(0xffb9bfcd),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Date Of birth",
                            // style: titleStyle,
                          ),
                        ),
                        Text(
                          personalDetails.dob,
                          style: TextStyle(
                            color: Color(0xffb9bfcd),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Email",
                            // style: titleStyle,
                          ),
                        ),
                        Text(
                          personalDetails.email,
                          style: TextStyle(
                            color: Color(0xffb9bfcd),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        ),
      ),
    );
  }
}
