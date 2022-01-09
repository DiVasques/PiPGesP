import 'package:flutter/material.dart';

class Dimensions {
  static const double smallPadding = 5.0;
  static const double inBetweenItensPadding = 15.0;
  static const double mediumPadding = 38.0;
  static const double bigPadding = 60.0;
  static const double sidePadding = 15.0;
  static const double toppadding = 45.0;
  static const double buttonHeight = 52.0;
  static const double spacerWidth = 80.0;

  static const double frontPanelHeight = 65;
  static const double frontPanelOpenPercentage = 0.8;

  static const double profilePictureSize = 50;

  static const double cardElevation = 5.0;

  ///Returns the screen's ***height***
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  ///Returns the screen's ***width***
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  ///Returns a `SizedBox` of given ***height*** and no width, if no height is specified
  ///defaults to [inBetweenItensPadding]
  static Widget heightSpacer([double _height = inBetweenItensPadding]) {
    return SizedBox(
      height: _height,
    );
  }

  ///Returns a `SizedBox` of given ***width*** and no height, if no width is specified
  ///defaults to [inBetweenItensPadding]
  static Widget widthSpacer([double _width = inBetweenItensPadding]) {
    return SizedBox(
      width: _width,
    );
  }
}
