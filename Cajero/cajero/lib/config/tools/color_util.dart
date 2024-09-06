import 'package:flutter/material.dart';

class ColorUtil {
  static bool isColorLight(Color color) {
    // Convert the color to RGB values (0 to 1)
    final double r = color.red / 255.0;
    final double g = color.green / 255.0;
    final double b = color.blue / 255.0;

    // Calculate the luminance
    final double luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b;

    // Return true if the color is light, otherwise false
    return luminance > 0.5;
  }
}
