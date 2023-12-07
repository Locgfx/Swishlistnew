import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swishlist/api/login_signup_apis/signup_api.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/globals.dart';
import 'package:swishlist/create_new_account/register_account.dart';
import 'package:swishlist/models/setPassModel.dart';
import 'package:swishlist/signup/widgets/text_term_widget.dart';

import '../api/login_signup_apis/update_profile_api.dart';
import '../buttons/light_yellow.dart';
import '../constants/globals/shared_prefs.dart';
import '../login/login.dart';

class SetPassword extends StatefulWidget {
  final String email;
   SetPassword({Key? key, required this.email})
      : super(key: key);

  @override
  State<SetPassword> createState() =>
      _CreateNewAccountWithEmailState();
}

class _CreateNewAccountWithEmailState extends State<SetPassword> {
  // final updateNameController = TextEditingController();
  // final userNameController = TextEditingController();
  // final phoneNoController = TextEditingController();
  // final numberController = TextEditingController();

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  SetPassModel response = SetPassModel();
  // LoginResponse? response;
  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();
  var formKey = GlobalKey<FormState>();
  bool show = false;
/*  bool show = false;*/
  @override
  Widget build(BuildContext context) {
    return TextFieldUnFocusOnTap(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarWidget(
                    onPop: () {
                      Navigator.pop(context);
                    },
                    title: '\Create new account',
                  ),
              /*    Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      "Last step!",
                      style: AppTextStyle().textColorA8A8A816w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Add your photo and name",
                      style: AppTextStyle().textColor29292924w700,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: ClipOval(
                          child: pickedImage.path.isEmpty
                              ? Image.asset(
                                  'assets/images/Frame1000002321.png',
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  pickedImage,
                                  width: 1.sw,
                                  height: 420,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        // backgroundImage: AssetImage('assets/images/Frame1000002321.png'),
                      ),
                      Positioned(
                        top: 60,
                        right: 0.0,
                        child: GestureDetector(
                          onTap: () async {
                            XFile? v = await _imgPicker.pickImage(
                                source: ImageSource.gallery);
                            if (v != null) {
                              setState(
                                () {
                                  pickedImage = File(v.path);
                                },
                              );
                            }
                            print(pickedImage);
                          },
                          child: Image.asset('assets/images/Frame1000003015.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: 328.w,
                    decoration: BoxDecoration(
                        color: ColorSelect.colorEDEDF1,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        validator: (value) {
                          return value!.length < 4
                              ? 'Name must be greater than 4 characters'
                              : null;
                        },
                        controller: updateNameController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 24),
                            border: InputBorder.none,
                            hintText: "Your full name"),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: 328.w,
                    decoration: BoxDecoration(
                        color: ColorSelect.colorEDEDF1,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: userNameController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 24),
                            border: InputBorder.none,
                            hintText: "Your username"),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: 328.w,
                    decoration: BoxDecoration(
                        color: ColorSelect.colorEDEDF1,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: numberController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 24),
                            border: InputBorder.none,
                            hintText: "Add your mobile no"),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  SizedBox(
                    height: 52.h,
                    width: 328.w,
                    child: show
                        ? LoadingLightYellowButton()
                        : YellowButtonWithText(
                            backgroundColor: MaterialStateProperty.all(
                                ColorSelect.colorF7E641),
                            textStyleColor: ColorSelect.color292929,
                            onTap: () {
                              setState(() {
                                show = !show;
                              });
                              Timer timer = Timer(Duration(seconds: 5), () {
                                setState(() {
                                  show = false;
                                });
                              });
                              // if(formKey.currentState!.validate()) {
                              createAccountApi(
                                name: updateNameController.text,
                                userName: userNameController.text,
                                email: widget.email,
                                phone: numberController.text,
                                photo: pickedImage.isAbsolute
                                    ? pickedImage.path
                                    : '',
                              ).then((value) async {
                                if (value['status'] ==
                                        true *//*&&
                                  response!.status == true*//*
                                    ) {
                                  SharedPrefs()
                                      .setUserPhoto(pickedImage.toString());
                                  SharedPrefs()
                                      .setName(updateNameController.toString());
                                  SharedPrefs()
                                      .setUsername(userNameController.toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Login(),
                                    ),
                                  );
                                  Fluttertoast.showToast(
                                      msg: "Account Successfully Created");
                                  // print(pickedImage.toString());
                                  // print(updateNameController.text);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Account Failed to create check your details");
                                }
                              });
                              // }
                            },
                            title: 'Create Account'),
                  ),
                ],*/

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
                    'Enter a password',
                    style: AppTextStyle().textColor29292916w500,
                  ),

                  SizedBox(height: 16),
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
                        controller: passController,
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
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Confirm your password',
                    style: AppTextStyle().textColor29292916w500,
                  ),
                  SizedBox(height: 16),
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
                        controller: confirmPassController,
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
                  ),
                  SizedBox(height: 16,),
                  SizedBox(
                    height: 52.h,
                    width: 328.w,
                    child: show
                        ? LoadingLightYellowButton()
                        :
                        passController.text.isEmpty ||
                            confirmPassController.text.isEmpty ?
                    LightYellowButtonWithText(
                        backgroundColor: MaterialStateProperty.all(
                            ColorSelect.colorFCF5B6),
                        textStyleColor: ColorSelect.colorB5B07A,
                        onTap: () {
                        },
                        title: 'Please add all details') :
                    YellowButtonWithText(
                      backgroundColor: MaterialStateProperty.all(
                          ColorSelect.colorF7E641),
                      textStyleColor:

                      Colors.black,
                      onTap: () {
                        setState(() {
                          show = !show;
                        });
                        Timer timer = Timer(Duration(seconds: 2), () {
                          setState(() {
                            show = false;
                          });
                        });

                       // if (isChecked) {
                          // SharedPrefs().setPassword(passwordController.text);
                          // print(passwordController.text);
                          if (formKey.currentState!.validate()) {

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









                            signupSetPassword(email: widget.email,
                                pass: passController.text,
                                confirmPass: confirmPassController.text).then((value) {
                                  if(value['error'] == false){


                                    Fluttertoast.showToast(msg: value['message']);
                                    String rToken = value['token'];
                                    print(value['token']);
                                   // SharedPrefs().setRegisterToken(response.token.toString());

                                    // print('sss${  SharedPrefs().setRegisterToken(token)}');

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>  CreateNewAccountWithEmail(
                                          token: rToken,

                                          email:widget.email,),
                                      ),
                                    );

                                  }else{
                                    Fluttertoast.showToast(msg: value['message']);
                                  }
                            });


                          }
                      //  }
                      },
                      title: 'Next',
                    ),
                  ),


          ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
