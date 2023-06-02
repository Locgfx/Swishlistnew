import 'package:flutter/material.dart';

import '../constants/color.dart';

class RedButtonWithText extends StatelessWidget {
  final MaterialStateProperty<Color> backgroundColor;
  final Color textStyleColor;
  final Function onTap;
  final String title;
  final Image image;
  const RedButtonWithText(
      {Key? key,
      required this.backgroundColor,
      required this.textStyleColor,
      required this.onTap,
      required this.title,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: backgroundColor,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ))),
      onPressed: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          image,
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: AppTextStyle()
                .textColorFFFFFF14w500, //TextStyle(fontSize: 16, color: textStyleColor),
          ),
        ],
      ),
    );
  }
}
