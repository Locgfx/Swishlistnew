import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/buttons/white_button.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/login/reset_password_via_email.dart';

import '../../signup/signup_with_email.dart';

class RowCreateNewAccountWidget extends StatelessWidget {
  const RowCreateNewAccountWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpWithEmail()));

            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => CreateNewAccount()));
          },
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Image.asset('assets/images/Polygon162.png'),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Create a new account",
                  style: AppTextStyle().textColor00000014w500,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.white,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Reset password via...",
                            style: AppTextStyle().textColor29292920w500,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   "Select reset method",
                          //   style: AppTextStyle().textColor70707014w400,
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // SizedBox(
                          //   height: 52.h,
                          //   width: 328.w,
                          //   child: WhiteButtonWithText(
                          //       backgroundColor:
                          //           MaterialStateProperty.all(Colors.white),
                          //       textStyleColor: ColorSelect.color292929,
                          //       onTap: () {
                          //         Navigator.pop(context);
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     ResetPasswordViaPhone()));
                          //       },
                          //       title: 'Phone'),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 52.h,
                            width: 328.w,
                            child: WhiteButtonWithText(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              textStyleColor: ColorSelect.color292929,
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ResetPasswordViaEmail()));
                              },
                              title: 'Email',
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 12),
            margin: EdgeInsets.only(right: 14),
            child: Text(
              "Forgot Password ?",
              style: AppTextStyle().textColor00000014w500,
            ),
          ),
        )
      ],
    );
  }
}
