import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  final Function onTap;
  final String iconName;
  const AppBarIcon({
    Key? key,
    required this.onTap,
    required this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 24,
        width: 24,
        margin: EdgeInsets.symmetric(horizontal: 6),
        color: Colors.transparent,
        child: Image.asset(
          "assets/images/$iconName.png",
          color: Colors.black,
        ),
      ),
    );
  }
}
