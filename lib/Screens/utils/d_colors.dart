import 'dart:ui';

import 'package:flutter/material.dart';

const d_colorPrimary = Color(0xFF6270DD);
const d_colorPrimary_light = Color(0XFFFFEEEE);
const d_colorPrimaryDark = Color(0xFF6270DD);
const d_colorAccent = Color(0xFFFE7940);

const d_textColorPrimary = Color(0XFF333333);
const d_textColorSecondary = Color(0XFF747474);

const d_app_background = Color(0XFFf8f8f8);
const d_view_color = Color(0XFFDADADA);

const d_sign_in_background = Color(0XFFDADADA);

const d_white = Color(0XFFffffff);
const d_icon_color = Color(0XFF747474);
const d_selected_tab = Color(0XFFFCE9E9);
const d_red = Color(0XFFF10202);
const d_blue = Color(0XFF1D36C0);
const d_edit_text_background = Color(0XFFE8E8E8);
const d_shadow = Color(0X70E2E2E5);
var dWhite = materialColor(0XFFFFFFFF);
var dTextColorPrimary = materialColor(0XFF212121);
const shadow_color = Color(0X95E9EBF0);
const d_color_primary_light = Color(0XFFFCE8E8);
const d_bg_bottom_sheet = Color(0XFFFFF1F1);

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor materialColor(colorHax) {
  return MaterialColor(colorHax, color);
}

MaterialColor colorCustom = MaterialColor(0XFF5959fc, color);
