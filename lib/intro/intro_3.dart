import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/color.dart';

class Intro3 extends StatefulWidget {
  final Function onBackTap;
  const Intro3({Key? key, required this.onBackTap}) : super(key: key);

  @override
  State<Intro3> createState() => _Intro3State();
}

class _Intro3State extends State<Intro3> {
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
            SizedBox(
              height: 36,
            ),
            Text(
              "Invite friends so you can see each other’s profiles.",
              textAlign: TextAlign.center,
              style: AppTextStyle().textColor29292926w700,
            ),
            SizedBox(height: 16),
            Text(
              "You control what info each friend can and cannot see and none of your info is ever public.",
              textAlign: TextAlign.center,
              style: AppTextStyle().textColor70707014w400,
            ),
            Spacer(),
            Expanded(flex: 6, child: Image.asset('assets/images/i3.png')),
            Spacer(),
            /*Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Intro4()));
                  },
                  child: Image.asset('assets/images/Frame1022.png')),
            )*/
          ],
        ),
      ),
    );
  }
}
