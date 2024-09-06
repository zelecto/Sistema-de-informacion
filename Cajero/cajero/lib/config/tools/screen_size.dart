import 'package:flutter/material.dart';

class ScreenSize {
  static Size getSize(BuildContext context) => MediaQuery.of(context).size;
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
