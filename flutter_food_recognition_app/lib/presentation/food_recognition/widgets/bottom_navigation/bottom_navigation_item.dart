import 'package:flutter/material.dart';

class BottomNavigationItem {
  final String title;
  final String image;
  final VoidCallback callAction;

  BottomNavigationItem({
    required this.title,
    required this.image,
    required this.callAction,
  });
}
