import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/login/widgets/left_column_widget.dart';

class ResetPasswordEnterNewPassword extends StatefulWidget {
  const ResetPasswordEnterNewPassword({Key? key}) : super(key: key);

  @override
  State<ResetPasswordEnterNewPassword> createState() =>
      _ResetPasswordEnterNewPasswordState();
}

class _ResetPasswordEnterNewPasswordState
    extends State<ResetPasswordEnterNewPassword> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Reset password",
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
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            children: [
              Row(
                children: [
                  LeftColumnWidget(),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter your registered phone number",
                        style: AppTextStyle().textColor29292918w500,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Verification link sent",
                        style: AppTextStyle().textColor65AA5A14w500,
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Text(
                        "Verify phone number",
                        style: AppTextStyle().textColor29292918w500,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Number verified",
                          style: AppTextStyle().textColor65AA5A14w500,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Enter new password",
                        style: AppTextStyle().textColor29292918w500,
                      ),
                      Text(
                        "Type your new password",
                        style: AppTextStyle().textColor70707014w400,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 280.w,
                        decoration: BoxDecoration(
                            color: ColorSelect.colorEDEDF1,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter new password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 280.w,
                        decoration: BoxDecoration(
                            color: ColorSelect.colorEDEDF1,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Renter new password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 52.h,
                        width: 87.w,
                        child: YellowButtonWithText(
                            backgroundColor: MaterialStateProperty.all(
                                ColorSelect.colorF7E641),
                            textStyleColor: ColorSelect.color292929,
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ResetPasswordEnterNewPassword()));
                            },
                            title: 'Save'),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
