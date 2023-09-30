import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/profile_page/profile.dart';

import '../api/user_apis/delete_account_api.dart';
import '../api/user_apis/profile_apis.dart';
import '../buttons/red_button.dart';
import '../buttons/red_text_white_color_button.dart';
import '../buttons/white_button.dart';
import '../models/profile_model.dart';
import 'change_password.dart';
import 'delete_account.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  bool isLoading = false;
  // ProfileModel? profile;
  ProfileModel profile = ProfileModel();
  getProfile() {
    isLoading = true;
    var resp = getProfileDetails();
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          profile = ProfileModel.fromJson(value);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Delete Account",
              style: AppTextStyle().textColor29292916w500,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserProfile(),
                  ),
                );
              },
              child: Container(
                  padding: EdgeInsets.only(left: 3, right: 3),
                  height: 24,
                  width: 24,
                  // color: Colors.red,
                  child: SvgPicture.asset("assets/icons/Vectoredit.svg")),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/Vector190.png')),
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Loading()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Username",
                        style: AppTextStyle().textColor70707014w400,
                      ),
                      Spacer(),
                      Text(
                        profile.data!.user!.username!.toString() == "null"
                            ? "Add Your Username"
                            : profile.data!.user!.username!.toString(),
                        style: AppTextStyle().textColor29292914w400,
                      ),
                      /*SizedBox(
                  width: 10.w,
                ),
                Image.asset("assets/images/Vector175.png"),*/
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Email",
                        style: AppTextStyle().textColor70707014w400,
                      ),
                      Spacer(),
                      Text(
                        profile.data!.user!.email!.toString() == "null"
                            ? "Add your email"
                            : profile.data!.user!.email!.toString(),
                        style: AppTextStyle().textColor29292914w400,
                      ),
                      /*SizedBox(
                  width: 10.w,
                ),
                Image.asset("assets/images/Vector175.png"),*/
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Phone",
                        style: AppTextStyle().textColor70707014w400,
                      ),
                      Spacer(),
                      Text(
                        profile.data!.user!.phone!.toString() == "null"
                            ? "Add your phone no"
                            : profile.data!.user!.phone!.toString(),
                        // "+18397840844",
                        style: AppTextStyle().textColor29292914w400,
                      ),
                      /*SizedBox(
                  width: 10.w,
                ),
                Image.asset("assets/images/Vector175.png"),*/
                    ],
                  ),
                  // SizedBox(
                  //   height: 40.h,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ChangePassword()));
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "Change Password",
                  //         style: AppTextStyle().textColor70707014w400,
                  //       ),
                  //       Spacer(),
                  //       Image.asset("assets/images/Vector175.png"),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 40.h,
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Google",
                  //       style: AppTextStyle().textColor70707014w400,
                  //     ),
                  //     Spacer(),
                  //     Image.asset("assets/images/Vector175.png"),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 40.h,
                  // ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Contacts syncing",
                  //       style: AppTextStyle().textColor70707014w400,
                  //     ),
                  //     Spacer(),
                  //     Image.asset("assets/images/Vector175.png"),
                  //   ],
                  // ),
                  Spacer(),
                  Text(
                    "On deleting the account it will permanently delete all your app data",
                    style: AppTextStyle().textColor29292914w400,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 34),
                    child: SizedBox(
                      height: 52.h,
                      width: 328.w,
                      child: RedTextWhiteButtonWithText(
                        title: 'Erase All Data',
                        textStyleColor: ColorSelect.colorC33C3C,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteAccountDialog();
                              });
                        },
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Delete this Account?",
                style: AppTextStyle().textColor29292918w500,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "This Account with will be permanently deleted",
                style: AppTextStyle().textcolor82828212w400,
              ),
              SizedBox(
                height: 44.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: WhiteButtonWithText(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          textStyleColor: ColorSelect.color292929,
                          onTap: () {
                            Navigator.pop(context);
                            /*Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ResetPasswordViaPhone()));*/
                          },
                          title: 'No'),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: RedButtonWithText(
                        backgroundColor:
                            MaterialStateProperty.all(ColorSelect.colorCE5252),
                        textStyleColor: ColorSelect.colorFFFFFF,
                        onTap: () {
                          deleteAccountApi().then((value) async {
                            if (value['status'] ==
                                    true /*&&
                              response!.status == true*/
                                ) {
                              Fluttertoast.showToast(
                                  msg: 'Your OTP is ${value['data']['otp']}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DeleteAccount(),
                                ),
                              );
                              // print(pickedImage.toString());
                              // print(updateNameController.text);
                            } else {
                              Fluttertoast.showToast(msg: value['message']);
                            }
                          });
                        },
                        title: 'Yes, Delete',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
