import 'package:flutter/material.dart';

import '../constants/color.dart';

class RedTextWhiteButtonWithText extends StatelessWidget {
  final MaterialStateProperty<Color> backgroundColor;
  final Color textStyleColor;
  final Function onTap;
  final String title;
  const RedTextWhiteButtonWithText(
      {Key? key,
      required this.backgroundColor,
      required this.textStyleColor,
      required this.onTap,
      required this.title})
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
            side: BorderSide(width: 1, color: ColorSelect.colorC33C3C),
          ),
        ),
      ),
      onPressed: () {
        onTap();
      },
      child: Center(
        child: Text(
          title,
          style: AppTextStyle()
              .textColor29292914w500, //TextStyle(fontSize: 16, color: textStyleColor),
        ),
      ),
    );
  }
}
