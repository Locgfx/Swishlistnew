import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/constants/color.dart';

import '../../models/profile_model.dart';
import 'date_picker.dart';

class NameRowWidget extends StatelessWidget {
  final  ProfileModel profile;
  const NameRowWidget({
    Key? key, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Text(
            "Name",
            style: AppTextStyle().textColor70707014w400,
          ),
          Spacer(),
          Text(
            profile.data!.name!.toString() == '' ?
            '+ Add':
            profile.data!.name!.toString(),
            style: profile.data!.name! == '' ? AppTextStyle().textColorD5574514w500 :
            AppTextStyle().textColor29292914w400,
          ),
          // SizedBox(
          //   width: 5.w,
          // ),
          // Image.asset("assets/images/image46.png"),
          // SizedBox(
          //   width: 20.w,
          // ),
          // SvgPicture.asset("assets/icons/forwordarrow.svg")
        ],
      ),
    );
  }
}

class GenderRowWidget extends StatelessWidget {
  final  ProfileModel profile;
  const GenderRowWidget({
    Key? key, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Text(
            "Gender",
            style: AppTextStyle().textColor70707014w400,
          ),
          Spacer(),
          Text(
            profile.data!.gender!.toString() == '' ?
            '+ Add':profile.data!.gender!.toString(),
            style: profile.data!.gender! == '' ? AppTextStyle().textColorD5574514w500 :
            AppTextStyle().textColor29292914w400,
          ),
          // SizedBox(
          //   width: 5.w,
          // ),
          // Image.asset("assets/images/image461.png"),
          // SizedBox(
          //   width: 20.w,
          // ),
          // SvgPicture.asset("assets/icons/forwordarrow.svg")
        ],
      ),
    );
  }
}

class DateOfBirthWidget extends StatelessWidget {
  final  ProfileModel profile;
  const DateOfBirthWidget({
    Key? key, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DatePickerWidget(onPop: (DateTime ) {  }, maximumDate: 2020,),
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Text(
              "Date of birth",
              style: AppTextStyle().textColor70707014w400,
            ),
            Spacer(),
            Text(
              profile.data!.dob!.toString() == '' ?
              '+ Add':
              profile.data!.dob!.toString(),
              style: profile.data!.dob! == '' ? AppTextStyle().textColorD5574514w500 :
              AppTextStyle().textColor29292914w400,
            ),
            // SizedBox(
            //   width: 5.w,
            // ),
            // Image.asset("assets/images/image461.png"),
            // SizedBox(
            //   width: 20.w,
            // ),
            // SvgPicture.asset("assets/icons/forwordarrow.svg")
          ],
        ),
      ),
    );
  }
}

class OccupationRowWidget extends StatelessWidget {
  final  ProfileModel profile;
  const OccupationRowWidget({
    Key? key, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Occupation",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          profile.data!.occupation!.toString() == '' ?
          '+ Add' :
          profile.data!.occupation!.toString(),
          style: profile.data!.occupation! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
        // SizedBox(
        //   width: 5.w,
        // ),
        // Image.asset("assets/images/image46.png"),
        // SizedBox(
        //   width: 20.w,
        // ),
        // SvgPicture.asset("assets/icons/forwordarrow.svg")
      ],
    );
  }
}

class RelationshipStatusRowWidget extends StatelessWidget {
  final  ProfileModel profile;
  const RelationshipStatusRowWidget({
    Key? key, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Relationship Status",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        SizedBox(
          width: 5.w,
        ),
         Text(
           profile.data!.relationStatus!.toString() == ''?
           '+ Add' :
           profile.data!.relationStatus!.toString(),
         style: profile.data!.relationStatus! == '' ? AppTextStyle().textColorD5574514w500 :
         AppTextStyle().textColor29292914w400,
         ),
        // Image.asset("assets/images/information1.png"),
        // SizedBox(
        //   width: 20.w,
        // ),
        // SvgPicture.asset("assets/icons/forwordarrow.svg")
      ],
    );
  }
}
