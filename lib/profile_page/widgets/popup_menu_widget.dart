import 'dart:ui';
import 'package:flutter/material.dart';

class Popupmen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget icon;
  const Popupmen({Key? key, required this.menuList, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}
