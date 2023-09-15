import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/constants/color.dart';

class RowEmailFacebookGoogleWidget extends StatelessWidget {
  const RowEmailFacebookGoogleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Expanded(
          flex: 10,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/gmail.svg",
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    'Email',
                    style: AppTextStyle().textColor00000014w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Expanded(
          flex: 10,
          child: Container(
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
              child: SvgPicture.asset("assets/icons/logos_facebook.svg",
                  height: 20, width: 20, fit: BoxFit.scaleDown)),
        ),
        Spacer(),
        Expanded(
          flex: 10,
          child: Container(
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
              child: SvgPicture.asset(
                  "assets/icons/flat-color-icons_google.svg",
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown)),
        ),
        Spacer(),
      ],
    );
  }
}
