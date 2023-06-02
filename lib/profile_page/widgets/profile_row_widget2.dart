import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';

import '../../models/profile_model.dart';

class EmailRowWidget extends StatelessWidget {
  final  ProfileModel profile;
  const EmailRowWidget({
    Key? key, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Email",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          profile.data!.user!.email.toString() == '' ?
          "+ Add" :
          profile.data!.user!.email.toString(),
          // '${SharedPrefs().getEmail()}',
          style:profile.data!.email! == '' ? AppTextStyle().textColorD5574514w500 :
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

class PhoneRowWidget extends StatelessWidget {
  final  ProfileModel profile;
  const PhoneRowWidget({
    Key? key, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Phone",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          profile.data!.user!.phone.toString() == ''?
          '+ Add' :
          profile.data!.user!.phone.toString(),
          style: profile.data!.phone! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
        // SizedBox(width: 5.w,),
        // Image.asset("assets/images/image461.png"),
        // SizedBox(width: 20.w,),
        // SvgPicture.asset("assets/icons/forwordarrow.svg")
      ],
    );
  }
}

class AlternatePhoneRowWidget extends StatelessWidget {
  final  ProfileModel profile;
  const AlternatePhoneRowWidget({
    Key? key, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Alternate phone no",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          profile.data!.alternatePhone!.toString() == '' ?
          '+ Add' :
          profile.data!.alternatePhone!.toString(),
          style: profile.data!.alternatePhone! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
        // Spacer(),
        // SizedBox(width: 5.w),
        // Image.asset("assets/images/information1.png"),
        // SizedBox(width: 20.w),
        // SvgPicture.asset("assets/icons/forwordarrow.svg")
      ],
    );
  }
}

class AddressRowWidget extends StatelessWidget {
  final  ProfileModel profile;
  const AddressRowWidget({
    Key? key, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Text(profile.data!.homeAddress!.toString() == '' ?
          '+ Add':
          profile.data!.homeAddress!.toString(),
            style: profile.data!.homeAddress! == '' ? AppTextStyle().textColorD5574514w500 :
            AppTextStyle().textColor29292914w400,
          ),
          // Spacer(),
          // Image.asset("assets/images/image462.png"),
          // SizedBox(width: 20.w),
          // SvgPicture.asset("assets/icons/forwordarrow.svg")
        ],
      ),
    );
  }
}

class WorkRowWidget extends StatelessWidget {
  final  ProfileModel profile;
  const WorkRowWidget({
    Key? key, required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Work",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        SizedBox(width: 5.w),
        Text(
          profile.data!.workAddress!.toString() == '' ?
          '+ Add' :
          profile.data!.workAddress!.toString(),
          style: profile.data!.workAddress! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
        // Image.asset("assets/images/information1.png"),
        // SizedBox(width: 20.w),
        // SvgPicture.asset("assets/icons/forwordarrow.svg")
      ],
    );
  }
}
