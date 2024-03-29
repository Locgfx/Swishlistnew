import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/globals.dart';
import 'package:swishlist/signup/widgets/text_term_widget.dart';

import '../api/login_signup_apis/update_profile_api.dart';
import '../buttons/light_yellow.dart';
import '../constants/globals/shared_prefs.dart';
import '../login/login.dart';
import '../models/login_models.dart';

class CreateNewAccountByPhone extends StatefulWidget {
  final String phoneNo;
  const CreateNewAccountByPhone({Key? key, required this.phoneNo})
      : super(key: key);

  @override
  State<CreateNewAccountByPhone> createState() => _CreateNewAccountByPhone();
}

class _CreateNewAccountByPhone extends State<CreateNewAccountByPhone> {
  final updateNameController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final emailController = TextEditingController();

  LoginResponse? response;
  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldUnFocusOnTap(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(
                onPop: () {
                  Navigator.pop(context);
                },
                title: 'Create new account',
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
                    controller: emailController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 24),
                        border: InputBorder.none,
                        hintText: "abc@gmail.com"),
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
                        backgroundColor:
                            MaterialStateProperty.all(ColorSelect.colorF7E641),
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
                          createAccountApi(
                            name: updateNameController.text,
                            userName: userNameController.text,
                            email: emailController.text,
                            phone: widget.phoneNo,
                            photo:
                                pickedImage.isAbsolute ? pickedImage.path : '',
                          ).then((value) async {
                            if (value['status'] ==
                                    true /*&&
                              response!.status == true*/
                                ) {
                              // print(response);
                              Fluttertoast.showToast(
                                  msg: "Account Successfully Created");
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
                              // print(pickedImage.toString());
                              // print(updateNameController.text);
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Account Failed to create check your details");
                            }
                          });
                        },
                        title: 'Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
