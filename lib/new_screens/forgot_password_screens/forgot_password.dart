import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/api/forgot_password_api/forgot_password_api.dart';
import 'package:swishlist/api/login_signup_apis/signup_api.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/globals.dart';
import 'package:swishlist/new_screens/forgot_password_screens/forgot_password_email_verification.dart';
import 'package:swishlist/signup/email_verfication.dart';
import 'package:swishlist/signup/widgets/text_term_widget.dart';

class ForgotPasswordWithEmail extends StatefulWidget {
  const ForgotPasswordWithEmail({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPasswordWithEmail> createState() => _ForgotPasswordWithEmailState();
}

class _ForgotPasswordWithEmailState extends State<ForgotPasswordWithEmail> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _passwordVisible = false;
  // bool isChecked = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  bool show = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldUnFocusOnTap(
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: SingleChildScrollView(
            child: Column(
              children: [
                // Row(
                //   children: [
                //     Transform.scale(
                //       scale: 1.3,
                //       child: Checkbox(
                //         splashRadius: 50,
                //         materialTapTargetSize: MaterialTapTargetSize.padded,
                //         checkColor: ColorSelect.color292929,
                //         activeColor: ColorSelect.colorF7E641,
                //         value: isChecked,
                //         shape: CircleBorder(),
                //         onChanged: (bool? value) {
                //           setState(() {
                //             isChecked = value!;
                //           });
                //         },
                //       ),
                //     ),
                //     Container(
                //       width: 300.w,
                //       padding: const EdgeInsets.only(right: 20, top: 16),
                //       child: RichText(
                //         text: TextSpan(
                //           text: 'I have read and agree to SwishList',
                //           style: AppTextStyle().textColor29292914w500,
                //           children: <TextSpan>[
                //             TextSpan(
                //               text: ' Terms of ',
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ),
                //             TextSpan(
                //               text: 'Services',
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //             TextSpan(
                //               text: ' and',
                //               style: AppTextStyle().textColor29292914w500,
                //             ),
                //             TextSpan(
                //               text: ' Privacy Policy',
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 30),
                SizedBox(
                  height: 52.h,
                  width: 328.w,
                  child: show
                      ? LoadingLightYellowButton()
                      : emailController.text.isNotEmpty ?
                  LightYellowButtonWithText(
                    backgroundColor: emailController.text.isNotEmpty
                        ? MaterialStateProperty.all(
                        ColorSelect.colorF7E641)
                        : MaterialStateProperty.all(
                        ColorSelect.colorFCF5B6),
                    textStyleColor: emailController.text.isNotEmpty
                        ? Colors.black
                        : ColorSelect.colorB5B07A,
                    onTap: () {
                      if(emailController.text.contains("@")) {
                        setState(() {
                          show = !show;
                        });
                        Timer timer = Timer(Duration(seconds: 2), () {
                          setState(() {
                            show = false;
                          });
                        });

                        if (emailController.text.isNotEmpty) {
                          // SharedPrefs().setPassword(passwordController.text);
                          // print(passwordController.text);
                          if (formKey.currentState!.validate()) {

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ForgotPasswordEmailVerification(
                            //       email: emailController.text,
                            //     ),
                            //   ),
                            // );

                            /*signUpApi(
                                  context: context,
                                  emailPhone: emailController.text,
                                  password: passwordController.text,
                                ).then((value) async {
                                  if (value['status'] == true) {
                                    // SharedPrefs().setPassword(passwordController.text);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EmailVerification(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      ),
                                    );
                                    print(passwordController.text);
                                    Fluttertoast.showToast(
                                        msg: 'Please check your mail for Otp');
                                    // Fluttertoast.showToast(
                                    //     msg:
                                    //         'Your OTP is ${value['data']['otp']}');

                                    // SharedPrefs().setPassword(passwordController.toString());
                                    // print(SharedPrefs().setPassword(passwordController.toString()));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: value['message']);
                                  }
                                });*/

                            forgotPasswordApi(email: emailController.text).then((value) {
                              if(value['error'] == false){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPasswordEmailVerification(
                                      email: emailController.text,
                                    ),
                                  ),
                                );
                                Fluttertoast.showToast(msg: value['message']);

                              } else{
                                Fluttertoast.showToast(msg: value['message']);
                              }
                            });

                          }
                        }
                      } else {
                        CustomFlutterToast.show(context: context, message: "Please Enter Valid Email");

                      }


                    },
                    title: 'Next',
                  ):
                  LightYellowButtonWithText(
                    backgroundColor:
                    MaterialStateProperty.all(
                        ColorSelect.colorFCF5B6),
                    textStyleColor:  ColorSelect.colorB5B07A,
                    onTap: () {},
                    title: 'Next',
                  ),


                ),
                SizedBox(height: 50),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppBarWidget(
                  onPop: () {
                    Navigator.pop(context);
                  },
                  title: 'Forgot Password',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text(
                    "Enter your email",
                    style: AppTextStyle().textColor29292924w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 20),
                  child: Text(
                    "SwishList will need to verify your email\ before creating new password",
                    textAlign: TextAlign.center,
                    style: AppTextStyle().textColor70707014w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: 328.w,
                    decoration: BoxDecoration(
                        color: ColorSelect.colorEDEDF1,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'This field is required';
                        //   }
                        //   if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        //     return "Please enter a valid email address";
                        //   }
                        //   return null;
                        // },
                        // validator: (val) {
                        //   if (val!.isEmpty ||
                        //       !val.contains('@')
                        //   ) {
                        //     return 'Please enter a valid email address';
                        //   }
                        //   return null;
                        // },
                        controller: emailController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 24),
                            border: InputBorder.none,
                            hintText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ),
                /* Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: 328.w,
                    decoration: BoxDecoration(
                        color: ColorSelect.colorEDEDF1,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        obscureText: _obscureText,
                        controller: passwordController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 24),
                            border: InputBorder.none,
                            suffixIcon: InkWell(
                              onTap: _toggle,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: Image(
                                    image: AssetImage(_obscureText
                                        ? 'assets/icons/eye-disable.png'
                                        : 'assets/icons/eye.png')),
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(
                              maxHeight: 40,
                              maxWidth: 40,
                            ),
                            hintText: "Password"),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
