import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/constants/color.dart';
import '../dashboard/products/my_friends_except.dart';
import '../dashboard/products/only_selected_friends.dart';

class ProfilePrivacy extends StatefulWidget {
  const ProfilePrivacy({Key? key}) : super(key: key);

  @override
  State<ProfilePrivacy> createState() => _ProfilePrivacyState();
}

class _ProfilePrivacyState extends State<ProfilePrivacy> {
  Object cF = Object();
  bool checkedFriend = false;
  bool checkedFriendonly = false;
  bool checkedFamilyonly = false;
  bool checkedonlyme = false;
  bool checkedmyfriend = false;
  bool checkedonlyselected = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(children: [
              Text(
                "Profile Privacy",
                style: AppTextStyle().textColor29292916w500,
              ),
              SizedBox(
                width: 130.w,
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
          Padding(
            padding: const EdgeInsets.only(right: 200, top: 20),
            child: Text(
              "Who can see my profile",
              style: AppTextStyle().textColor70707012w400,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selected = 0;
              });
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: selected == 0
                          ? ColorSelect.colorF7E641
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected == 0
                            ? ColorSelect.colorF7E641
                            : ColorSelect.kAFAFAF,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.done,
                        size: 18,
                        color:
                            selected == 0 ? Colors.black : Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Image.asset('assets/images/Vector55.png'),
                  FriendsAndFamilyWidget()
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selected = 1;
              });
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: selected == 1
                          ? ColorSelect.colorF7E641
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected == 1
                            ? ColorSelect.colorF7E641
                            : ColorSelect.kAFAFAF,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.done,
                        size: 18,
                        color:
                            selected == 1 ? Colors.black : Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Image.asset('assets/images/users01.png'),
                  FriendsOnlyWidget()
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selected = 2;
              });
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: selected == 2
                          ? ColorSelect.colorF7E641
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected == 2
                            ? ColorSelect.colorF7E641
                            : ColorSelect.kAFAFAF,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.done,
                        size: 18,
                        color:
                            selected == 2 ? Colors.black : Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Image.asset('assets/images/users01.png'),
                  FamilyOnlyWidget()
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selected = 3;
              });
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: selected == 3
                          ? ColorSelect.colorF7E641
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected == 3
                            ? ColorSelect.colorF7E641
                            : ColorSelect.kAFAFAF,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.done,
                        size: 18,
                        color:
                            selected == 3 ? Colors.black : Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Image.asset('assets/images/lock40.png'),
                  OnlyMeWidget()
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selected = 4;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyFriendsExcept(),
                ),
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: selected == 4
                          ? ColorSelect.colorF7E641
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected == 4
                            ? ColorSelect.colorF7E641
                            : ColorSelect.kAFAFAF,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.done,
                        size: 18,
                        color:
                            selected == 4 ? Colors.black : Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Image.asset('assets/images/user-polygon.png'),
                  SizedBox(
                    width: 10.w,
                  ),
                  MyFriendExceptWidget(),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: SvgPicture.asset("assets/icons/forwordarrow.svg"),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {
              setState(() {
                selected = 5;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OnlySelectedFriends(),
                ),
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: selected == 5
                          ? ColorSelect.colorF7E641
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected == 5
                            ? ColorSelect.colorF7E641
                            : ColorSelect.kAFAFAF,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.done,
                        size: 18,
                        color:
                            selected == 5 ? Colors.black : Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Image.asset('assets/images/user-polygon.png'),
                  SizedBox(
                    width: 10.w,
                  ),
                  OnlySelectedFriendWidget(),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: SvgPicture.asset("assets/icons/forwordarrow.svg"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FriendsAndFamilyWidget extends StatelessWidget {
  const FriendsAndFamilyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Friends and family',
            style: AppTextStyle().textColor38383814w500,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Anyone on swishList",
            style: AppTextStyle().textColor9E9E9E12w500,
          ),
        )
      ],
    );
  }
}

class FriendsOnlyWidget extends StatelessWidget {
  const FriendsOnlyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Text(
            'Friends only',
            style: AppTextStyle().textColor38383814w500,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Only friends whom i add",
            style: AppTextStyle().textColor9E9E9E12w500,
          ),
        )
      ],
    );
  }
}

class FamilyOnlyWidget extends StatelessWidget {
  const FamilyOnlyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Text(
            'Family only',
            style: AppTextStyle().textColor38383814w500,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Only friends whom i add",
            style: AppTextStyle().textColor9E9E9E12w500,
          ),
        )
      ],
    );
  }
}

class OnlyMeWidget extends StatelessWidget {
  const OnlyMeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Text(
            'Only me',
            style: AppTextStyle().textColor38383814w500,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "No one except me",
            style: AppTextStyle().textColor9E9E9E12w500,
          ),
        )
      ],
    );
  }
}

class MyFriendExceptWidget extends StatelessWidget {
  const MyFriendExceptWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            'My friends except...',
            style: AppTextStyle().textColor38383814w500,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Hide from some friends",
            style: AppTextStyle().textColor9E9E9E12w500,
          ),
        )
      ],
    );
  }
}

class OnlySelectedFriendWidget extends StatelessWidget {
  const OnlySelectedFriendWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Only selected friends',
            style: AppTextStyle().textColor38383814w500,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Hide from some friends",
            style: AppTextStyle().textColor9E9E9E12w500,
          ),
        )
      ],
    );
  }
}
