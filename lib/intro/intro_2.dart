import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/constants/color.dart';

class Intro2 extends StatefulWidget {
  final Function onBackTap;
  const Intro2({Key? key, required this.onBackTap}) : super(key: key);

  @override
  State<Intro2> createState() => _Intro2State();
}

class _Intro2State extends State<Intro2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 40,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            //widget.onBackTap();
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              "assets/icons/arrowback.svg",
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        width: 1.sw,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 36,
            ),
            Text(
              "Create your profile with sizes, preferences, and products you want.",
              textAlign: TextAlign.center,
              style: AppTextStyle().textColor29292926w700,
            ),
            Spacer(),
            Expanded(flex: 6, child: Image.asset('assets/images/i2.png')),
            Spacer(),
            /*Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Intro3()));
                  },
                  child: Image.asset('assets/images/Frame102.png')),
            )*/
          ],
        ),
      ),
    );
  }
}
