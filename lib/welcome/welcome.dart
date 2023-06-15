import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/login/login.dart';
import '../api/social_signin/google_signin.dart';
import '../signup/signup_with_email.dart';
import '../signup/signup_with_phone.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            Center(child: Image.asset('assets/images/image225.png')),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Welcome to SwishList",
                style: AppTextStyle().textColor29292924w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: SizedBox(
                height: 52.h,
                width: 328.w,
                child: YellowButtonWithText(
                    backgroundColor:
                        MaterialStateProperty.all(ColorSelect.colorF7E641),
                    textStyleColor: ColorSelect.color292929,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpWithPhone()));
                    },
                    title: 'Signup with Phone'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Text(
                "Or continue with",
                style: AppTextStyle().textColor70707012w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignUpWithEmail(),
                      ),
                    );
                  },
                  child: Container(
                    height: 48,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            width: 1, color: ColorSelect.colorA3A3A3)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SvgPicture.asset(
                            "assets/icons/gmail.svg",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Email',
                            style: AppTextStyle().textColor00000014w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 48,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            width: 1, color: ColorSelect.colorA3A3A3)),
                    child: SvgPicture.asset("assets/icons/logos_facebook.svg",
                        height: 20, width: 20, fit: BoxFit.scaleDown)),
                GestureDetector(
                  onTap: () async {
                    final auth = await GoogleSignInClass().googleLogin();
                    log(auth.idToken.toString());
                  },
                  child: Container(
                      height: 48,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                              width: 1, color: ColorSelect.colorA3A3A3)),
                      child: SvgPicture.asset(
                          "assets/icons/flat-color-icons_google.svg",
                          height: 20,
                          width: 20,
                          fit: BoxFit.scaleDown)
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Login(),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 30, top: 40),
                        child: RichText(
                            text: TextSpan(
                                text: 'Already a member?',
                                style: AppTextStyle().textColor29292914w500,
                                children: <TextSpan>[
                              TextSpan(
                                  text: ' Log in',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                              ),
                                ],
                            ),
                        ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SvgPicture.asset("assets/icons/Polygon16.svg",
                            height: 20, width: 20, fit: BoxFit.scaleDown
                        ),
                    ),
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
