import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/constants/color.dart';

class Intro1 extends StatefulWidget {
  final Function onBackTap;
  const Intro1({Key? key, required this.onBackTap}) : super(key: key);

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () {
            widget.onBackTap();
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              "assets/icons/arrowback.svg",
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: 1.sw,
        child: Column(
          children: [
            SizedBox(height: 36),
            Text(
              "Search products on Amazon and Etsy, directly through SwishList and add them to your profile.",
              textAlign: TextAlign.center,
              style: AppTextStyle().textColor29292926w700,
            ),
            Spacer(),
            Expanded(
              flex: 10,
              child: Image.asset('assets/images/Screenshot.png'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
