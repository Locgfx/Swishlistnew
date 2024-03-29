import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/expanded/link_members_account.dart';

import '../buttons/grey_border_button.dart';

class AddFamilyMember extends StatefulWidget {
  const AddFamilyMember({
    Key? key,
  }) : super(key: key);

  @override
  State<AddFamilyMember> createState() => _AddFamilyMemberState();
}

class _AddFamilyMemberState extends State<AddFamilyMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Add family member",
              style: AppTextStyle().textColor29292916w500,
            ),
          ],
        ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Text(
              "\Does the person have a \n     SwishList account ?",
              style: AppTextStyle().textColor29292924w700,
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/100481.png',
            ),
            Text(
              "Link family members with an existing SwishList\n account or invite them to join. You can also create \n                and manage child profiles.",
              style: AppTextStyle().textColor70707012w400,
            ),
            Spacer(),
            SizedBox(
              height: 52.h,
              width: 328.w,
              child: YellowButtonWithText(
                backgroundColor:
                    MaterialStateProperty.all(ColorSelect.colorF7E641),
                textStyleColor: ColorSelect.color292929,
                title: 'Yes',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LinkMembersAccount()));
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SizedBox(
                height: 52.h,
                width: 328.w,
                child: GreyBorderButtonWithText(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  textStyleColor: ColorSelect.color292929,
                  title: 'No, invite them to SwishList',
                  onTap: () {
                    if (Platform.isIOS) {
                      setState(() {
                        Share.share(
                            'https://apps.apple.com/us/app/swishlist/id6447429473');
                      });
                    } else {
                      setState(() {
                        Share.share(
                            'https://play.google.com/store/apps/details?id=com.locgfx.swishlist&pcampaignid=web_share');
                      });
                    }
                    // setState(() {
                    //   // Share.share('Check Out SwishList');
                    // });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
