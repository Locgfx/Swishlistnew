import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/color.dart';

class InterestRow1Widget extends StatelessWidget {
  const InterestRow1Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 32,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          child: Center(
            child: Text(
              "Cycling",
              style: AppTextStyle().textColor29292913w400,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          height: 32,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          child: Center(
            child: Text("Reading", style: AppTextStyle().textColor29292913w400),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          height: 32,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          child: Center(
            child: Text(
              "Fishing",
              style: AppTextStyle().textColor29292913w400,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          height: 32,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          child: Center(
            child: Text(
              "Fishing",
              style: AppTextStyle().textColor29292913w400,
            ),
          ),
        )
      ],
    );
  }
}

class InterestRow2Widget extends StatelessWidget {
  const InterestRow2Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 32,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          child: Center(
            child: Text("Swimming"),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          height: 32,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          child: Center(
            child: Text("Singing"),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          height: 32,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          child: Center(
            child: Text("Trekking"),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          height: 32,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          child: Center(
            child: Text("Coding"),
          ),
        )
      ],
    );
  }
}

class InterestRow3Widget extends StatelessWidget {
  const InterestRow3Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 32,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          child: Center(
            child: Text(
              "Biking",
              style: AppTextStyle().textColor29292913w400,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          height: 32,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          child: Center(
            child: Text(
              "Watches",
              style: AppTextStyle().textColor29292913w400,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          height: 32,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          child: Center(
            child: Text(
              "Movies and Shows",
              style: AppTextStyle().textColor29292913w400,
            ),
          ),
        ),
      ],
    );
  }
}
