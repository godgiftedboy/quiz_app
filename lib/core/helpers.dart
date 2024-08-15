import 'package:flutter/material.dart';

double getHeight(BuildContext context) {
  double height = MediaQuery.sizeOf(context).height;
  return height;
}

double getWidth(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;

  return width;
}
