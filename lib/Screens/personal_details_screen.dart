import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:miniProject/Screens/dashboard.dart';
import 'package:miniProject/theme.dart';
import 'package:nb_utils/nb_utils.dart';

class PersonalDetails extends StatefulWidget {
  static const routeName = '/personaldetails';

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController;
  TextEditingController _nameController;
  TextEditingController _genderController;

  String _gender = 'Male';
  String _fullName = '';
  String _email = '';

  bool _loading = false;

  GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();

  Future<void> _submitData() async {
    FocusScope.of(context).unfocus();
    if (_image == null) {
      print('Plese select photo');
    } else {
      final User user = await FirebaseAuth.instance.currentUser;
      final uid = user.uid;
      final phone = user.phoneNumber;
      print(phone);
      print(uid);
      final url = 'https://miniproject-dc6b4.firebaseio.com/$uid/profile.json';

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(uid + '.jpg');
      await ref.putFile(_image).onComplete;
      final imageUrl = await ref.getDownloadURL();

      await http.put(url,
          body: json.encode({
            'mobile': phone,
            'fullName': _fullName,
            'email': _email,
            'gender': _gender,
            'data': true,
            'imageUrl': imageUrl,
          }));
      // Navigator.of(context).pushReplacementNamed('/homepage');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('perDetAvl', true);
      print(preferences.getBool('perDetAvl'));
      print(_fullName);
      print(_email);
      print(_gender);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DashBoard()));
    }
  }

  Future<Map> getUser() async {
    final user = await FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    print(uid);
    // final response = await http
    //     .get('https://gurukrupa-472c8.firebaseio.com/$uid/profile.json');
    // return json.decode(response.body);
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ))
        : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.purple[300], Colors.indigo[300]])),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Personal",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 48,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Details",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 48,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Container(
                              height: 90,
                              width: 90,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                image: DecorationImage(
                                    image: _image == null
                                        ? CachedNetworkImageProvider(
                                            'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png')
                                        : FileImage(_image)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  // hintText: 'Enter Full Name',
                                  // hintStyle: TextStyle(color: Colors.white),
                                  labelText: 'Full Name',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    this._fullName = value;
                                  });
                                },
                              ),
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  // hintText: 'abc@xyz.com',
                                  // hintStyle: TextStyle(color: Colors.white),
                                  labelText: 'Email Adress',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Email';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    this._email = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Gender",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              RadioListTile(
                                activeColor: Colors.black,
                                value: 'Male',
                                groupValue: _gender,
                                title: Text(
                                  'Male',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                              RadioListTile(
                                activeColor: MyColors.primaryColor,
                                value: 'Female',
                                groupValue: _gender,
                                title: Text(
                                  'Female',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 10),
                                    constraints:
                                        const BoxConstraints(maxWidth: 200),
                                    child: RaisedButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _submitData();
                                        }
                                      },
                                      color: MyColors.primaryColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14))),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Next',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                                color:
                                                    MyColors.primaryColorLight,
                                              ),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
