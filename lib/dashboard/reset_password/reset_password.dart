import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/dashboard/reset_password/reset_password_otp.dart';

import '../../api/login_signup_apis/reset_password_api.dart';
import '../../buttons/light_yellow.dart';
import '../../constants/color.dart';
import '../../constants/globals/globals.dart';
import '../../constants/globals/shared_prefs.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();

  bool show = false;
  @override
  Widget build(BuildContext context) {
    return TextFieldUnFocusOnTap(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Text(
            "Reset Password",
            style: AppTextStyle().textColor29292916w500,
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/amico.png",
                    height: 194,
                    width: 264,
                  ),
                ),
                SizedBox(
                  height: 88,
                ),
                Text(
                  'Enter your registered email',
                  style: AppTextStyle().textColor29292916w500,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: 1.sw,
                    height: 52,
                    decoration: BoxDecoration(
                        color: ColorSelect.colorEDEDF1,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        onChanged: (v) {
                          setState(() {});
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "email",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 52,
                  child: emailController.text.isEmpty
                      ? LightYellowButtonWithText(
                          backgroundColor: MaterialStateProperty.all(
                              ColorSelect.colorFCF5B6),
                          textStyleColor: ColorSelect.colorB5B07A,
                          onTap: () {},
                          title: 'Next')
                      : show
                          ? LoadingLightYellowButton()
                          : LightYellowButtonWithText(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorSelect.colorF7E641),
                              textStyleColor: Colors.black,
                              onTap: () {
                                setState(() {
                                  show = !show;
                                });
                                Timer timer = Timer(Duration(seconds: 2), () {
                                  setState(() {
                                    show = false;
                                  });
                                });
                                if (emailController.text.isNotEmpty) {
                                  resetPassGenerateOtpApi(
                                          emailPhone: emailController.text)
                                      .then((value) async {
                                    if (value['status'] == true) {
                                      SharedPrefs()
                                          .setEmail(emailController.text);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResetPasswordOtp()),
                                      );
                                      Fluttertoast.showToast(
                                          msg:
                                              'Your OTP is ${value['data']['otp']}');
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: value['message']);
                                    }
                                  });
                                }
                              },
                              title: 'Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
