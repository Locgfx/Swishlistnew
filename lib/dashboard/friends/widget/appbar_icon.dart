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
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap();
      },
      child: Container(
        height: 30,
        width: 30,
        padding: EdgeInsets.all(3),
        child: Image.asset(
          "assets/images/$iconName.png",
          color: Colors.black,
        ),
      ),
    );
  }
}

class AppBarIconFriendProduct extends StatelessWidget {
  final Function onTap;
  final Widget child;
  const AppBarIconFriendProduct({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap();
      },
      child: Container(
        height: 30,
        width: 30,
        padding: EdgeInsets.all(3),
        child: child,
      ),
    );
  }
}
