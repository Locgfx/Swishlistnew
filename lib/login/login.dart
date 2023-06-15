import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/login/widgets/row_create_new_account_widget.dart';
import 'package:swishlist/signup/widgets/text_term_widget.dart';
import 'package:swishlist/welcome/welcome.dart';
import '../api/login_signup_apis/login_api.dart';
import '../dashboard/dashboard.dart';
import '../models/login_models.dart';

class Login extends StatefulWidget {
  const Login({Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phoneEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  LoginResponse? response;
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppBarWidget(
                  onPop: () {
                    // Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)
                        => Welcome())
                    );
                  },
                  title: 'Login',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Text(
                    "Welcome back buddy!",
                    style: AppTextStyle().textColor29292924w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: 328.w,
                    decoration: BoxDecoration(
                        color: ColorSelect.colorEDEDF1,
                        borderRadius: BorderRadius.all(Radius.circular(8),
                        ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        onChanged: (v) {
                          setState(() {});
                        },
                        controller: phoneEmailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 24),
                          border: InputBorder.none,
                          hintText: "Enter phone number/email",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: 328.w,
                    decoration: BoxDecoration(
                        color: ColorSelect.colorEDEDF1,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        onChanged: (v) {
                          setState(() {});
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 24),
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  height: 52.h,
                  width: 328.w,
                  child: show ? LoadingLightYellowButton(): LightYellowButtonWithText(
                    backgroundColor:(phoneEmailController.text.isNotEmpty && passwordController.text.isNotEmpty)
                            ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                            : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                    textStyleColor:
                    (phoneEmailController.text.isNotEmpty && passwordController.text.isNotEmpty)
                            ? Colors.black
                            : ColorSelect.colorB5B07A,
                    onTap: () {
                      setState(() {
                        show = !show;
                      });
                      Timer timer = Timer(Duration(seconds: 2), () {
                        setState(() {
                          show = false;
                        });
                      });
                      /*Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneVerification()));*/
                      if (phoneEmailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                      if(_formKey.currentState!.validate()) {
                       /* setState(() {
                          loading = true;
                        });*/
                        login(
                            context: context,
                            email: phoneEmailController.text,
                            password: passwordController.text,
                            ).then((value) {
                              response = value;
                            if(response?.status != null && response!.status == true) {
                            SharedPrefs().setLoginTrue();
                            SharedPrefs().setEmail(phoneEmailController.text);
                            SharedPrefs().setPassword(passwordController.text);
                            SharedPrefs().setLoginToken(response!.token);
                            SharedPrefs().setId(response!.data.id.toString());
                            SharedPrefs().setName(response!.data.name.toString());
                            SharedPrefs().setUsername(response!.data.username.toString());
                            SharedPrefs().setUserPhoto(response!.data.photo.toString());
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Dashboard(response: response!,),
                              ),
                            );

                          }
                        });
                      } else {
                          loading = false;

                      }
                      }
                    },
                    title: 'Next'
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Text(
                    "Or continue with",
                    style: AppTextStyle().textColor70707012w400,
                  ),
                ),
                // RowEmailFacebookGoogleWidget(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20,
                      left: 20
                  ),
                  child: RowCreateNewAccountWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
