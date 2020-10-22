import 'package:flutter/cupertino.dart';
import 'package:miniProject/Screens/utils/constants.dart';
import 'package:miniProject/Screens/utils/d_colors.dart';

class Notice {
  final String title, description, image;
  final Color color;

  Notice({this.title, this.color, this.description, this.image});
}

class GridItem {
  final String title, image, tag;

  GridItem({this.title, this.image, this.tag});
}

final List<Notice> notices = [
  Notice(
      title: 'Stay Home',
      color: Color(0xFF79A7D3),
      description: 'bhfjdhfbjd',
      image: 'https://i.postimg.cc/dtGqyY8X/mask-woman.png'),
  Notice(
      title: 'Stay Home',
      color: Color(0xFF4EBAD4),
      description: 'bhfjdhfbjd',
      image: doctor_man),
  Notice(
      title: 'Stay Home',
      color: Color(0xFFF57E7E),
      description: 'bhfjdhfbjd',
      image: 'https://i.postimg.cc/bN0hvRPf/remote-work-woman.png'),
];

final List<GridItem> gridItems = [
  GridItem(
      title: 'Diagnostics',
      image: 'https://i.postimg.cc/vHj30jdK/diagnostic-1.png',
      tag: 'diagnostics'),
  GridItem(
      title: 'Shots',
      image: 'https://i.postimg.cc/dV2t5byQ/injection.png',
      tag: 'shots'),
  GridItem(
      title: 'Consultation',
      image: 'https://i.postimg.cc/6Ts4vCDM/consultant.png',
      tag: 'consulation'),
  GridItem(
      title: 'Ambulance',
      image: 'https://i.postimg.cc/pLjbCz3D/ambulance.png',
      tag: 'ambulance'),
  GridItem(
      title: 'Nurse',
      image: 'https://i.postimg.cc/0NC4XfnJ/nurse.png',
      tag: 'nurse'),
  GridItem(
      title: 'Lab Work',
      image: 'https://i.postimg.cc/VstV3mK8/lab.png',
      tag: 'labwork'),
];

class GridItemdoc {
  final String title, image;
  GridItemdoc({this.title, this.image});
}

final List<GridItemdoc> gridItemsdoctors = [
  GridItemdoc(
      title: 'Dentiest', image: 'https://i.postimg.cc/bwtHxJ0J/teeth.png'),
  GridItemdoc(
      title: 'Cardiologist', image: 'https://i.postimg.cc/qBDVPQXj/heart.png'),
  GridItemdoc(
      title: 'Dermatolodist', image: 'https://i.postimg.cc/L8HWh1Tn/skin.png'),
  GridItemdoc(
      title: 'Orthopaedic',
      image: 'https://i.postimg.cc/bNf5PhjV/orthopedics.png'),
  GridItemdoc(
      title: 'Gastroenterologist',
      image: 'https://i.postimg.cc/d1xFj95H/gastroenterologist.png'),
  GridItemdoc(
      title: 'Radiologists', image: 'https://i.postimg.cc/bwtHxJ0J/teeth.png'),
  // GridItemdoc(
  //     title: 'Orthopaedic', image: 'https://i.postimg.cc/ncZsjFQX/osteoporosis.png'),
];
