import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:miniProject/Helpers/doctor_list_obj.dart';

enum DoctorType {
  dentist,
  physiotherapist,
  multispecialist,
}

class Doctor {
  final String name, imageUrl;
  final DoctorType type;
  Doctor({this.name, this.imageUrl, this.type});
}

class DoctorList {
  // singleton
  static final DoctorList _singleton = DoctorList._internal();
  factory DoctorList() => _singleton;
  DoctorList._internal();
  static DoctorList get shared => _singleton;
  static List<DoctorListObj> doctorList = [
    // Doctor(
    //     name: 'Amit Butani',
    //     imageUrl:
    //         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     type: DoctorType.dentist),
    // Doctor(
    //     name: 'Amit Butani',
    //     imageUrl:
    //         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     type: DoctorType.dentist),
    // Doctor(
    //     name: 'Amit Butani',
    //     imageUrl:
    //         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     type: DoctorType.dentist),
    // Doctor(
    //     name: 'Amit Butani',
    //     imageUrl:
    //         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     type: DoctorType.dentist),
    // Doctor(
    //     name: 'Amit Butani',
    //     imageUrl:
    //         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     type: DoctorType.dentist),
    // Doctor(
    //     name: 'Amit Butani',
    //     imageUrl:
    //         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     type: DoctorType.dentist),
    // Doctor(
    //     name: 'Amit Butani',
    //     imageUrl:
    //         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     type: DoctorType.dentist),
    // Doctor(
    //     name: 'Amit Butani',
    //     imageUrl:
    //         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     type: DoctorType.dentist),
    // Doctor(
    //     name: 'Amit Butani',
    //     imageUrl:
    //         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     type: DoctorType.dentist),
    // Doctor(
    //     name: 'Amit Butani',
    //     imageUrl:
    //         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     type: DoctorType.dentist),
    // Doctor(
    //     name: 'Amit Butani',
    //     imageUrl:
    //         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     type: DoctorType.dentist),
  ];

  Future<List<DoctorListObj>> getDoctorList() async {
    final url = 'https://miniproject-dc6b4.firebaseio.com/Doctors.json';
    final response = await http.get(
      url,
    );
    final map = json.decode(response.body) as Map<String, dynamic>;
    print(response.body);
    List<DoctorListObj> newList = [];
    map.forEach((key, value) {
      // print(value['personalDetails']);
      final res = DoctorListObj.fromJson(value);
      newList.add(res);
      print(res.personalDetails.address);
    });
    doctorList = newList;
    return doctorList;
  }
}
