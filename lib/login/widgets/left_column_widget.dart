import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/constants/color.dart';

class LeftColumnWidget extends StatelessWidget {
  const LeftColumnWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(color: ColorSelect.colorF7E641)),
          ),
        ),
        Container(
          height: 260.h,
          width: 1.w,
          decoration: BoxDecoration(color: ColorSelect.colorE0E0E0),
        ),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(color: ColorSelect.colorE0E0E0)),
        ),
        Container(
          height: 100.h,
          width: 1.w,
          decoration: BoxDecoration(color: ColorSelect.colorE0E0E0),
        ),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(color: ColorSelect.colorE0E0E0)),
        ),
      ],
    );
  }
}
