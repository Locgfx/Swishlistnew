import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/color.dart';

class OnlySelectedFriends extends StatefulWidget {
  const OnlySelectedFriends({Key? key}) : super(key: key);

  @override
  State<OnlySelectedFriends> createState() => _OnlySelectedFriendsState();
}

class _OnlySelectedFriendsState extends State<OnlySelectedFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelect.colorFFFFFF,
        elevation: 0,
        title: Column(
          children: [
            Row(children: [
              Text(
                "Only selected friends...",
                style: AppTextStyle().textColor29292916w500,
              ),
            ]),
            Row(
              children: [
                Text(
                  "1 Selected",
                  style: AppTextStyle().textColor00000012w400,
                )
              ],
            )
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {}, child: Image.asset('assets/images/Vector190.png')),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 1.sw,
              color: ColorSelect.colorFFFFFF,
              child: Column(children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 328.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorSelect.colorEDEDF1),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Image.asset("assets/images/Vectorse.png"),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Search"),
                          keyboardType: TextInputType.text,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
              ]),
            ),
            SizedBox(
              height: 22.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey,
                                backgroundImage: AssetImage(
                                    'assets/images/Rectangle319.png'),
                              ),
                              SizedBox(
                                width: 8.h,
                              ),
                              Text(
                                "Jan Levinson",
                                style: AppTextStyle().textColor00000014w400,
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/icons/removeadd.svg")
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 16,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
