import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/buttons/yellow_button.dart';

import '../constants/color.dart';

class Added extends StatefulWidget {
  const Added({Key? key}) : super(key: key);

  @override
  State<Added> createState() => _AddedState();
}

class _AddedState extends State<Added> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: ColorSelect.colorC4E3CB,
            height: 40.h,
            width: 1.sw,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 1.sw,
                child: Image.asset(
                  "assets/images/Frame1000003018.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: 120,
                left: 130,
                right: 130,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/images/Rectangle319.png'),
                ),
              ),
              Positioned(
                  top: 220,
                  left: 210,
                  child: Image.asset('assets/images/Frame100000301.png')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text(
              "Jan Lavinson added",
              style: AppTextStyle().textColor29292924w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Wife",
              style: AppTextStyle().textColor70707014w400,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: SizedBox(
              height: 52.h,
              width: 328.w,
              child: YellowButtonWithText(
                  backgroundColor:
                      MaterialStateProperty.all(ColorSelect.colorF7E641),
                  textStyleColor: ColorSelect.color292929,
                  onTap: () {
                    /*Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => UserDetails()));*/
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  title: 'Done'),
            ),
          ),
        ],
      ),
    );
  }
}
