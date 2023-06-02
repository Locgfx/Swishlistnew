import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/constants/color.dart';

class AppBarWidget extends StatelessWidget {
  final Function onPop;
  final String title;
  const AppBarWidget({
    Key? key,
    required this.onPop,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 40,
        centerTitle: false,
        title: Text(
          title,
          style: AppTextStyle().textColor29292916w500,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              onPop();
            },
            child: SvgPicture.asset(
              "assets/icons/arrowback.svg",
            ),
          ),
        ));
  }
}

class TextTermsWidget extends StatelessWidget {
  const TextTermsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text.rich(
          TextSpan(
            children: [],
          ),
        )
      ],
    );
  }
}
