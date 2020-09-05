import 'package:flutter/material.dart';

class ToggleWidget {
  static double orderSummeryWidth = 0;
  static double orderSummeryHeight = 0;

  static double orderSummeryYOffset = 0;
  static double orderSummeryXOffset = 0;

  static double showNoteYOffset = 0;
  static double showNoteHeight = 0;

  static double windowWidth = 0;
  static double windowHeight = 0;

  void toggleMe(int pageIndex, bool orientation, Size size) {
    switch (pageIndex) {
      case 0:
        orderSummeryWidth = windowWidth;
        orderSummeryYOffset = windowHeight;
        orderSummeryXOffset = 0;
        showNoteYOffset = windowHeight;
        break;
      case 1:
        orderSummeryWidth = windowWidth;
        orderSummeryYOffset =
            orientation ? size.height * .06 : size.height * .07;
        orderSummeryXOffset = 0;
        showNoteYOffset = windowHeight;
        break;
      case 2:
        orderSummeryWidth = windowWidth - 40;
        orderSummeryYOffset = 120;
        orderSummeryXOffset = 0;
        showNoteYOffset = 180;
        showNoteHeight = windowHeight;
        break;
    }
  }
}
