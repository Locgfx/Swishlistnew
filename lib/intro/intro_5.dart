import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/color.dart';

class Intro5 extends StatefulWidget {
  final Function onBackTap;
  const Intro5({Key? key, required this.onBackTap}) : super(key: key);

  @override
  State<Intro5> createState() => _Intro5State();
}

class _Intro5State extends State<Intro5> {
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
        width: 1.sw,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 36),
            Text(
              "Finally give and receive better gifts!",
              textAlign: TextAlign.center,
              style: AppTextStyle().textColor29292926w700,
            ),
            Spacer(),
            Expanded(flex: 6, child: Image.asset('assets/images/i5.png')),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
