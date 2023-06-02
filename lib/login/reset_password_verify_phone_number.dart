import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/login/reset_password_enter_new_password.dart';

import '../buttons/resend_with_two_text_button.dart';

class ResetPasswordVerifyPhoneNumber extends StatefulWidget {
  const ResetPasswordVerifyPhoneNumber({Key? key}) : super(key: key);

  @override
  State<ResetPasswordVerifyPhoneNumber> createState() =>
      _ResetPasswordVerifyPhoneNumberState();
}

class _ResetPasswordVerifyPhoneNumberState
    extends State<ResetPasswordVerifyPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 40,
        title: Text(
          "Reset password",
          style: AppTextStyle().textColor29292916w500,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/icons/arrowback.svg",
              )),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              border:
                                  Border.all(color: ColorSelect.colorF7E641)),
                        ),
                      ),
                      Container(
                        height: 180.h,
                        width: 1.w,
                        decoration:
                            BoxDecoration(color: ColorSelect.colorE0E0E0),
                      ),
                      Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(color: ColorSelect.colorE0E0E0)),
                      ),
                      Container(
                        height: 50.h,
                        width: 1.w,
                        decoration:
                            BoxDecoration(color: ColorSelect.colorE0E0E0),
                      ),
                      Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(color: ColorSelect.colorE0E0E0)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter your registered phone number",
                        style: AppTextStyle().textColor29292918w500,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Verification link sent",
                        style: AppTextStyle().textColor65AA5A14w500,
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Text(
                        "Verify phone number",
                        style: AppTextStyle().textColor29292918w500,
                      ),
                      Text(
                        "Click on the verification link sent to 18474624853. Link will be valid for 30 Minutes. ",
                        style: AppTextStyle().textColor70707014w400,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 52.h,
                            width: 149.w,
                            child: YellowButtonWithText(
                                backgroundColor: MaterialStateProperty.all(
                                    ColorSelect.colorF7E641),
                                textStyleColor: ColorSelect.color292929,
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResetPasswordEnterNewPassword()));
                                },
                                title: 'Open messages'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 52.h,
                            width: 126.w,
                            child: ResendButtonWithText(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              textStyleColor: ColorSelect.color292929,
                              onTap: () {
                                /*Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpWithPhone()));*/
                              },
                              title: 'Resend',
                              title1: '30s',
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Enter new password",
                        style: AppTextStyle().textColorA3A3A318w500,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
