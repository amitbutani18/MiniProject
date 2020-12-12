import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:miniProject/Helpers/doctor_list_obj.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UploadSedual with ChangeNotifier {
  Future<void> uploadSedual(
    DoctorListObj personalDetails,
  ) async {
    final User user = await FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    final phone = user.phoneNumber;
    print("upload");

    final url = 'https://miniproject-dc6b4.firebaseio.com/$uid/yourSedual.json';

    final url1 =
        'https://miniproject-dc6b4.firebaseio.com/Doctors/${personalDetails.personalDetails.uid}/yourSedual.json';
    await http.post(url,
        body: json.encode({
          'doctor_name': personalDetails.personalDetails.name,
          'date': "22/ 1 /2020",
          'time': "11 : 20",
        }));
    await http.post(url1,
        body: json.encode({
          'patient_number': phone,
          'date': "22/ 1 /2020",
          'time': "11 : 20",
        }));
    print("Success");
    // Navigator.of(context).pushReplacementNamed('/homepage');
  }
}
