import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/color.dart';

class AddFamilyMemberWidget extends StatelessWidget {
  const AddFamilyMemberWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: ColorSelect.colorEDEDF1),
            child: SvgPicture.asset("assets/icons/Union.svg",
                fit: BoxFit.scaleDown)),
        SizedBox(
          width: 10.w,
        ),
        Text(
          'Add family member',
          style: AppTextStyle().textColor29292914w500,
        ),
      ],
    );
  }
}

class ManageFamilyMembersWidget extends StatelessWidget {
  const ManageFamilyMembersWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: ColorSelect.colorEDEDF1),
            child: SvgPicture.asset(
              'assets/icons/userpro.svg',
              fit: BoxFit.scaleDown,
            )),
        SizedBox(
          width: 10.w,
        ),
        Text(
          'Manage family members',
          style: AppTextStyle().textColor29292914w500,
        ),
        Spacer(),
        Padding(
            padding: const EdgeInsets.only(right: 26),
            child: SvgPicture.asset("assets/icons/forwordarrow.svg")),
      ],
    );
  }
}

class MemberSettingsWidget extends StatelessWidget {
  const MemberSettingsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: ColorSelect.colorEDEDF1),
          child: SvgPicture.asset(
            "assets/icons/setting.svg",
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          'Settings',
          style: AppTextStyle().textColor29292914w500,
        ),
        Spacer(),
        Padding(
            padding: const EdgeInsets.only(right: 26),
            child: SvgPicture.asset("assets/icons/forwordarrow.svg")),
      ],
    );
  }
}

class ListDataWidget extends StatelessWidget {
  const ListDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage('assets/images/Rectangle319.png'),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Row(
              children: [
                Text(
                  "Jan Levinson",
                  style: AppTextStyle().textColor29292914w500,
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 30,
                  width: 50,
                  decoration: BoxDecoration(
                      color: ColorSelect.colorF6E3DB,
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Center(
                    child: Text(
                      " Wife",
                      style: AppTextStyle().textColor29292912w400,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: Text(
                "JanLovey22",
                style: AppTextStyle().textColor70707014w400,
              ),
            )
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
