import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/profile_page/profile_privacy.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(children: [
          Text(
            "Privacy",
            style: AppTextStyle().textColor29292916w500,
          ),
        ]),
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/icons/arrowback.svg",
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Text(
                "Who can see my info",
                style: AppTextStyle().textColor3D3D3D24w700,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Change your privacy setting",
                style: AppTextStyle().textColor70707012w400,
              ),
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePrivacy()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profile",
                            style: AppTextStyle().textColor00000014w400,
                          ),
                          Text(
                            "Everyone",
                            style: AppTextStyle().textColor75757512w400,
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 26),
                        child:
                            SvgPicture.asset("assets/icons/forwordarrow.svg"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePrivacy()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sizes and weights",
                            style: AppTextStyle().textColor00000014w400,
                          ),
                          Text(
                            "Everyone",
                            style: AppTextStyle().textColor75757512w400,
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        width: 20.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 26),
                        child:
                            SvgPicture.asset("assets/icons/forwordarrow.svg"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePrivacy()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Favourites",
                            style: AppTextStyle().textColor00000014w400,
                          ),
                          Text(
                            "Everyone",
                            style: AppTextStyle().textColor75757512w400,
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        width: 20.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 26),
                        child:
                            SvgPicture.asset("assets/icons/forwordarrow.svg"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePrivacy()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pets",
                            style: AppTextStyle().textColor00000014w400,
                          ),
                          Text(
                            "Everyone",
                            style: AppTextStyle().textColor75757512w400,
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(width: 20.w),
                      Padding(
                        padding: const EdgeInsets.only(right: 26),
                        child:
                            SvgPicture.asset("assets/icons/forwordarrow.svg"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePrivacy()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dates and events",
                            style: AppTextStyle().textColor00000014w400,
                          ),
                          Text(
                            "Everyone",
                            style: AppTextStyle().textColor75757512w400,
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(width: 20.w),
                      Padding(
                        padding: const EdgeInsets.only(right: 26),
                        child:
                            SvgPicture.asset("assets/icons/forwordarrow.svg"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePrivacy()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Family",
                            style: AppTextStyle().textColor00000014w400,
                          ),
                          Text(
                            "Everyone",
                            style: AppTextStyle().textColor75757512w400,
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(width: 20.w),
                      Padding(
                        padding: const EdgeInsets.only(right: 26),
                        child:
                            SvgPicture.asset("assets/icons/forwordarrow.svg"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
