import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/expanded/add_family_member.dart';
import 'package:swishlist/expanded/manage_family_members.dart';
import 'package:swishlist/expanded/member_settings.dart';
import 'package:swishlist/expanded/user_all_details.dart';
import 'package:swishlist/expanded/widgets/user_details_widgets.dart';
import 'package:swishlist/models/login_models.dart';

class UserDetails extends StatefulWidget {
  final LoginResponse response;
  const UserDetails({Key? key, 
    required this.response,
  }) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserAllDetails(response: widget.response,)));
                },
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          radius: 40.0,
                          lineWidth: 10.0,
                          percent: .25,
                          backgroundColor: ColorSelect.colorEDEDF1,
                          center:
                              Image.asset('assets/images/Rectangle1072.png'),
                          progressColor: Colors.black,
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorSelect.colorF7E641,
                              borderRadius: BorderRadius.all(
                                Radius.circular(80),
                              ),
                            ),
                            child: Text(
                              " 25% ",
                              style: AppTextStyle().textColor29292910w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Michael Scott",
                              style: AppTextStyle().textColor29292916w500,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset(
                              "assets/icons/Vector458.svg",
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 60, top: 20),
                          child: Text(
                            "Micheal139",
                            style: AppTextStyle().textColor70707014w400,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(Icons.more_vert)),
                  ],
                ),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: ListDataWidget(),
                    );
                  }),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddFamilyMember()));
                  /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddFamilyMemberDetails()));*/
                },
                child: AddFamilyMemberWidget(),
              ),
              SizedBox(
                height: 40.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ManageFamilyMembers()));
                },
                child: ManageFamilyMembersWidget(),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MemberSettings(response: widget.response,)));
                },
                child: MemberSettingsWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
