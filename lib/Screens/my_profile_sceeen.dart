import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:miniProject/Screens/dashboard.dart';
import 'package:miniProject/theme.dart';

class MyProfileScreen extends StatefulWidget {
  static const routeName = '/MyProfileScreen';

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController;
  TextEditingController _nameController;

  String _gender = '';
  String _fullName = '';
  String _email = '';

  bool _loading = false;

  Future<void> _submitData() async {
    FocusScope.of(context).unfocus();
    if (_image == null) {
      // print('Plese select photo');
      print('Amit');
      print(_nameController.text);
      print(_emailController.text);
      final User user = await FirebaseAuth.instance.currentUser;
      final uid = user.uid;
      final phone = user.phoneNumber;
      // print(phone);
      // print(uid);
      final url = 'https://miniproject-dc6b4.firebaseio.com/$uid/profile.json';
      await http.put(url,
          body: json.encode({
            'mobile': phone,
            'fullName': _nameController.text,
            'email': _emailController.text,
            'gender': _gender,
            'data': true,
            'imageUrl': _initImage,
          }));
      // Navigator.of(context).pushReplacementNamed('/homepage');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
    } else {
      final User user = await FirebaseAuth.instance.currentUser;
      final uid = user.uid;
      final phone = user.phoneNumber;
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
            'fullName': _nameController.text,
            'email': _emailController.text,
            'gender': _gender,
            'data': true,
            'imageUrl': imageUrl,
          }));
      // Navigator.of(context).pushReplacementNamed('/homepage');
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // preferences.setBool('perDetAvl', true);
      // print(preferences.getBool('perDetAvl'));
      // print(_fullName);
      // print(_email);
      // print(_gender);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
    }
  }

  Future<Map> getUser() async {
    final user = await FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    print(uid);
  }

  File _image;
  final picker = ImagePicker();
  String _initImage = '';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isInit = true;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      print("HEllo");
      var firebaseUser = await _auth.currentUser;
      var uid = firebaseUser.uid;
      final url = 'https://miniproject-dc6b4.firebaseio.com/$uid/profile.json';
      final response = await http.get(url);
      final map = json.decode(response.body) as Map<String, dynamic>;
      // print(map);
      print(map['imageUrl']);
      setState(() {
        _nameController = TextEditingController(text: map['fullName']);
        _initImage = map['imageUrl'];
        _emailController = TextEditingController(text: map['email']);
        _gender = map['gender'];
      });
      _isInit = false;
    }
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
                            "My",
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
                            "Profile",
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
                                        ? NetworkImage(_initImage)
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
                                validator: (map) {
                                  if (map.isEmpty) {
                                    return 'Please enter Name';
                                  }
                                  return null;
                                },
                                onChanged: (map) {
                                  setState(() {
                                    this._fullName = map;
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
                                validator: (map) {
                                  if (map.isEmpty) {
                                    return 'Please enter Email';
                                  }
                                  return null;
                                },
                                onChanged: (map) {
                                  setState(() {
                                    this._email = map;
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
                                onChanged: (map) {
                                  setState(() {
                                    _gender = map;
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
                                onChanged: (map) {
                                  setState(() {
                                    _gender = map;
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
