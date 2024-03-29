import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swishlist/api/login_signup_apis/update_profile_api.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/globals.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/login/login.dart';
import 'package:swishlist/signup/widgets/text_term_widget.dart';

class CreateNewAccountWithEmail extends StatefulWidget {
  final String email;
  const CreateNewAccountWithEmail({Key? key, required this.email})
      : super(key: key);

  @override
  State<CreateNewAccountWithEmail> createState() =>
      _CreateNewAccountWithEmailState();
}

class _CreateNewAccountWithEmailState extends State<CreateNewAccountWithEmail> {
  final updateNameController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final numberController = TextEditingController();

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
            child: Column(
              children: [
                AppBarWidget(
                  onPop: () {
                    Navigator.pop(context);
                  },
                  title: '\Create new account',
                ),
                Padding(
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
                              maxWidth: 90,
                              maxHeight: 90,
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
                      onChanged: (v) {
                        setState(() {});
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
                      onChanged: (v) {
                        setState(() {});
                      },
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
                      onChanged: (v) {
                        setState(() {
                          if (phoneNoController.text.trim().length == 10) {
                            FocusScope.of(context).unfocus();
                          }
                        });
                      },
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
                  child: updateNameController.text.isEmpty ||
                          userNameController.text.isEmpty ||
                          numberController.text.isEmpty ||
                          pickedImage.path.isEmpty
                      ? LightYellowButtonWithText(
                          backgroundColor: MaterialStateProperty.all(
                              ColorSelect.colorFCF5B6),
                          textStyleColor: ColorSelect.colorB5B07A,
                          onTap: () {
                            if (updateNameController.text.isNotEmpty ||
                                userNameController.text.isNotEmpty ||
                                numberController.text.isNotEmpty ||
                                pickedImage.path.isNotEmpty) {
                              if (pickedImage.path.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please add profile photo");
                              } else if (updateNameController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please add your name");
                              } else if (userNameController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please add your username");
                              } else if (phoneNoController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please add your phone no");
                              }
                            } else {
                              setState(() {
                                Fluttertoast.showToast(
                                    msg: "Please add all details");
                              });
                            }
                          },
                          title: 'Please add all details')
                      : show
                          ? LoadingLightYellowButton()
                          : YellowButtonWithText(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorSelect.colorF7E641),
                              textStyleColor: Colors.black,
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
                                          true /*&&
                              response!.status == true*/
                                      ) {
                                    SharedPrefs()
                                        .setUserPhoto(pickedImage.toString());
                                    SharedPrefs().setName(
                                        updateNameController.toString());
                                    SharedPrefs().setUsername(
                                        userNameController.toString());
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
