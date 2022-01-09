import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pipgesp/utils/hex_color.dart';


//import 'hex_color.dart';

//final Color appBackgroundColor= HexColor('#F4F4F4');


class AppColors{
  static final HexColor backgroundLightBlue = HexColor('e9f2f2');
  static final HexColor appBarBlue = HexColor('3bc2d7');

  static const Color appBarIconColor = Colors.white;

  // static final Color homeBackgroundColor = Colors.grey[200];
  
  static const Color detailsScreensBackground = Colors.white;

  static final Color defaultGrey = Colors.grey[700] as Color;

  static const Color gameBannerBackground = Colors.white70;
  static final Color pageViewSelectedIndicator = Colors.blueGrey[400] as Color;
  static const Color pageViewUnselectedIndicator = Colors.black38;

  static const Color linearPogressIndicator = Colors.lightBlueAccent;
  static final Color desiredProgressMarker = Colors.red[600] as Color;
  static const Color goalOfTheDayMarker = Colors.lightBlue;

  static const Color attributeTextColor = Colors.blueGrey;
}