import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/color.dart';

class SupportMemberSettingWidget extends StatelessWidget {
  const SupportMemberSettingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Support",
            style: AppTextStyle().textColorA3A3A312w400,
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Text(
                "Help & Support",
                style: AppTextStyle().textColor39393914w500,
              ),
              Spacer(),
              SvgPicture.asset("assets/icons/forwordarrow.svg")
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Agreements",
                style: AppTextStyle().textColor39393914w500,
              ),
              Spacer(),
              SvgPicture.asset("assets/icons/forwordarrow.svg")
            ],
          )
        ],
      ),
    );
  }
}
