import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:swishlist/constants/color.dart';

class LightYellowButtonWithText extends StatefulWidget {
  final MaterialStateProperty<Color> backgroundColor;
  final Color textStyleColor;
  final Function onTap;
  final String title;
  final double? size;

  LightYellowButtonWithText({
    Key? key,
    required this.backgroundColor,
    required this.textStyleColor,
    required this.onTap,
    required this.title,
    this.size,
  }) : super(key: key);

  @override
  State<LightYellowButtonWithText> createState() =>
      _LightYellowButtonWithTextState();
}

class _LightYellowButtonWithTextState extends State<LightYellowButtonWithText> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor: widget.backgroundColor,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: () {
        widget.onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: widget.size ?? 0),
        child: Center(
          child: Text(
            widget.title,
            style: AppTextStyle().textColorB5B07A14w500.copyWith(
                  color: widget.textStyleColor,
                ), //TextStyle(fontSize: 16, color: textStyleColor),
          ),
        ),
      ),
    );
  }
}

class LoadingLightYellowButton extends StatefulWidget {
  const LoadingLightYellowButton({
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingLightYellowButton> createState() =>
      _LoadingLightYellowButtonState();
}

class _LoadingLightYellowButtonState extends State<LoadingLightYellowButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor: MaterialStateProperty.all(ColorSelect.colorF7E641),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: () {},
      child: Center(
        child: LoadingAnimationWidget.waveDots(
          size: 40,
          // color: ColorSelect.colorF7E641,
          color: Colors.black38,
        ),
      ),
    );
  }
}
