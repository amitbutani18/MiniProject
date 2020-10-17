import 'package:flutter/cupertino.dart';
import 'package:miniProject/Screens/utils/constants.dart';
import 'package:miniProject/Screens/utils/d_colors.dart';

class Notice {
  final String title, description, image;
  final Color color;

  Notice({this.title, this.color, this.description, this.image});
}

class GridItem {
  final String title, image;
  GridItem({this.title, this.image});
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
      image: 'https://i.postimg.cc/vHj30jdK/diagnostic-1.png'),
  GridItem(
      title: 'Shots', image: 'https://i.postimg.cc/dV2t5byQ/injection.png'),
  GridItem(
      title: 'Consultation',
      image: 'https://i.postimg.cc/6Ts4vCDM/consultant.png'),
  GridItem(
      title: 'Ambulance', image: 'https://i.postimg.cc/pLjbCz3D/ambulance.png'),
  GridItem(title: 'Nurse', image: 'https://i.postimg.cc/0NC4XfnJ/nurse.png'),
  GridItem(title: 'Lab Work', image: 'https://i.postimg.cc/VstV3mK8/lab.png'),
];
