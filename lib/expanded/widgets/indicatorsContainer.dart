import 'package:flutter/material.dart';

class IndicatorContainer extends StatelessWidget {
  // final BorderRadiusGeometry radius;
  final Color color;
  const IndicatorContainer({Key? key,
    // required this.radius,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
           height: 8,
           decoration: BoxDecoration(
            color: color,
               borderRadius: BorderRadius.all(Radius.circular(0))),
    );
  }
}
