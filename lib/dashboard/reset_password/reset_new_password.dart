import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/login/login.dart';

import '../../api/reset_pass_api.dart';
import '../../buttons/light_yellow.dart';
import '../../constants/color.dart';
import '../../constants/globals/globals.dart';
import '../../constants/globals/shared_prefs.dart';
import '../../signup/widgets/text_term_widget.dart';

class ResetNewPassword extends StatefulWidget {
  final String email;
  const ResetNewPassword({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<ResetNewPassword> createState() => _ResetNewPasswordState();
}

class _ResetNewPasswordState extends State<ResetNewPassword> {
  final passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = passwordController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  final _formKey = GlobalKey<FormState>();
  // void _submit() {
  //   // validate all the form fields
  //   if (_formKey.currentState!.validate()) {}
  // }

  bool show = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldUnFocusOnTap(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWidget(
                  onPop: () {
                    Navigator.pop(context);
                  },
                  title: 'Reset Password',
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/bro.png",
                    height: 194,
                    width: 264,
                  ),
                ),
                SizedBox(
                  height: 88,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter a new password',
                        style: AppTextStyle().textColor29292916w500,
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: 1.sw,
                        height: 52,
                        decoration: BoxDecoration(
                            color: ColorSelect.colorEDEDF1,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a value';
                              }

                              return null;
                            },
                            obscureText: _obscureText,
                            onChanged: (v) {
                              setState(() {});
                            },
                            controller: passwordController,
                            decoration: InputDecoration(
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
                              border: InputBorder.none,
                              hintText: "New Password",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Confirm your new password',
                        style: AppTextStyle().textColor29292916w500,
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: 1.sw,
                        height: 52,
                        decoration: BoxDecoration(
                            color: ColorSelect.colorEDEDF1,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a value';
                              }

                              return null;
                            },
                            obscureText: _obscureText,
                            onChanged: (v) {
                              setState(() {});
                            },
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
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
                              border: InputBorder.none,
                              hintText: "Confirm New Password",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // SizedBox(
                //   height: 24,
                // ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 52,
                  child: passwordController.text.isEmpty ||
                          _confirmPasswordController.text.isEmpty
                      ? LightYellowButtonWithText(
                          backgroundColor: MaterialStateProperty.all(
                              ColorSelect.colorFCF5B6),
                          textStyleColor: ColorSelect.colorB5B07A,
                          onTap: () {},
                          title: 'Please Enter password')
                      : show
                          ? LoadingLightYellowButton()
                          : LightYellowButtonWithText(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorSelect.colorF7E641),
                              textStyleColor: Colors.black,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    show = !show;
                                  });
                                  Timer timer = Timer(Duration(seconds: 2), () {
                                    setState(() {
                                      show = false;
                                    });
                                  });
                                  if (passwordController.text !=
                                      _confirmPasswordController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Passwords do not match')),
                                    );
                                  } else {
                                    resetNewpApi(
                                            email: SharedPrefs()
                                                .getChangeEmail()
                                                .toString(),
                                            password: passwordController.text)
                                        .then((value) async {
                                      if (value['status'] == true) {
                                        // SharedPrefs().clearPrefs();
                                        SharedPrefs().setLoginFalse();
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: value['message']);
                                      }
                                    });
                                  }
                                }
                              },
                              title: 'Done'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
