import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/color.dart';
import 'my_friends_except.dart';
import 'only_selected_friends.dart';

class ProductPrivacy extends StatefulWidget {
  const ProductPrivacy({Key? key}) : super(key: key);

  @override
  State<ProductPrivacy> createState() => _ProductPrivacyState();
}

class _ProductPrivacyState extends State<ProductPrivacy> {
  bool checkedFriend = false;
  bool checkedFriendandfamily = false;
  bool checkedFamily = false;
  bool checkedOnlyme = false;
  bool checkedOnlyselect = false;
  bool checkedMyfriends = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelect.colorFFFFFF,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Text(
              "Product Privacy",
              style: AppTextStyle().textColor29292916w500,
            ),
            /*Spacer(),
          Image.asset("assets/images/filter06.png"),
          SizedBox(
            width: 20,
          ),
          Image.asset("assets/images/Vector.png"),
          SizedBox(
            width: 16,
          ),*/
          ],
        ),
        leading: Container(
          color: Colors.transparent,
          //padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/Vector190.png')),
        ),
      ),
      backgroundColor: ColorSelect.colorFFFFFF,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.h,
            ),
            Text(
              "Who can see this product",
              style: AppTextStyle().textcolor33333324w700,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "Select who can see your product",
              style: AppTextStyle().textcolor71717112w400,
            ),
            SizedBox(
              height: 32.h,
            ),
            Container(
              height: 40.h,
              width: 328.w,
              color: Colors.transparent,
              child: Row(
                children: [
                  Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        checkColor: Colors.grey,
                        activeColor: ColorSelect.colorF7E641,

                        //fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: checkedFriendandfamily,
                        shape: CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            checkedFriendandfamily = value!;
                          });
                        },
                      )),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    "Friends and family",
                    style: AppTextStyle().textColor00000014w400,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              height: 40.h,
              width: 328.w,
              color: Colors.transparent,
              child: Row(
                children: [
                  Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        checkColor: Colors.grey,
                        activeColor: ColorSelect.colorF7E641,

                        //fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: checkedFriend,
                        shape: CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            checkedFriend = value!;
                          });
                        },
                      )),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    "Friends only",
                    style: AppTextStyle().textColor00000014w400,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              height: 40.h,
              width: 328.w,
              color: Colors.transparent,
              child: Row(
                children: [
                  Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        checkColor: Colors.grey,
                        activeColor: ColorSelect.colorF7E641,

                        //fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: checkedFamily,
                        shape: CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            checkedFamily = value!;
                          });
                        },
                      )),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    "Family only",
                    style: AppTextStyle().textColor00000014w400,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              height: 40.h,
              width: 328.w,
              color: Colors.transparent,
              child: Row(
                children: [
                  Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        checkColor: Colors.grey,
                        activeColor: ColorSelect.colorF7E641,

                        //fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: checkedOnlyme,
                        shape: CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            checkedOnlyme = value!;
                          });
                        },
                      )),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    "Only me",
                    style: AppTextStyle().textColor00000014w400,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnlySelectedFriends()));
              },
              child: Container(
                height: 40.h,
                //width: 328.w,
                color: Colors.transparent,
                child: Row(
                  children: [
                    Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          checkColor: Colors.grey,
                          activeColor: ColorSelect.colorF7E641,

                          //fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: checkedOnlyselect,
                          shape: CircleBorder(),
                          onChanged: (bool? value) {
                            setState(() {
                              checkedOnlyselect = value!;
                            });
                          },
                        )),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "Only selected friends",
                      style: AppTextStyle().textColor00000014w400,
                    ),
                    Spacer(),
                    SvgPicture.asset("assets/icons/forwordarrow.svg"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyFriendsExcept()));
              },
              child: Container(
                height: 40.h,
                //width: 328.w,
                color: Colors.transparent,
                child: Row(
                  children: [
                    Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          checkColor: Colors.grey,
                          activeColor: ColorSelect.colorF7E641,

                          //fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: checkedMyfriends,
                          shape: CircleBorder(),
                          onChanged: (bool? value) {
                            setState(() {
                              checkedMyfriends = value!;
                            });
                          },
                        )),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "My friends except...",
                      style: AppTextStyle().textColor00000014w400,
                    ),
                    Spacer(),
                    SvgPicture.asset("assets/icons/forwordarrow.svg"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
