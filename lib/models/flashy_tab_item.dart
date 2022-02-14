import 'package:flutter/material.dart';

class FlashyTabBarItem {
  FlashyTabBarItem({
    required this.title,
    required this.icon,
    this.activeColor = const Color(0xff272e81),
    this.inActiveColor = const Color(0xff9496c1),
  });
  final Icon icon;
  final Color activeColor, inActiveColor;
  final Text title;
}
