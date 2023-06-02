import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swishlist/api/login_signup_apis/signup_api.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/signup/widgets/text_term_widget.dart';
import '../buttons/white_button.dart';
import '../constants/globals/globals.dart';
import '../constants/globals/shared_prefs.dart';
import '../create_new_account/create_new_account.dart';
import '../dashboard/dashboard.dart';
import '../models/login_models.dart';

class EmailVerification extends StatefulWidget {
  final String email;
  final String password;
  const EmailVerification({Key? key, required this.email, required this.password}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final otpController = TextEditingController();
  bool loading = false;
  LoginResponse? response;
  @override
  Widget build(BuildContext context) {
    return TextFieldUnFocusOnTap(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 52.h,
                width: 328.w,
                child: LightYellowButtonWithText(
                  backgroundColor: otpController.text.length == 4
                      ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                      : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                  textStyleColor: otpController.text.length == 4
                      ? Colors.black
                      : ColorSelect.colorB5B07A,
                  onTap: () {
                    if (otpController.text.length == 4) {
                      // resendOtp(
                      //   context: context,
                      //   emailPhone:widget.email,
                      // ).then((value) async {
                      //   if( value['status'] == true) {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => CreateNewAccount(
                      //         ),
                      //       ),
                      //     );
                      //     Fluttertoast.showToast(
                      //         msg:'Otp Verified');
                      //   } else {
                      //     Fluttertoast.showToast(
                      //         msg:value['message']);
                      //   }
                      // });

                      verifyOtp(
                        context: context,
                        otp: otpController.text,
                        email: widget.email,
                        password: widget.password,
                      ).then((value)async {
                        response = value;
                        if(response?.status != null && response!.status == true) {
                          print(response);
                          print(widget.password);
                          SharedPrefs().setLoginToken(response!.token);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CreateNewAccountWithEmail(email: widget.email,),
                            ),
                          );
                        }
                      });

                    }
                  },
                  title: 'Submit',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 52.h,
                width: 328.w,
                child: WhiteButtonWithText(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  textStyleColor: ColorSelect.color292929,
                  onTap: () {
                    resendOtp(
                        context: context,
                        emailPhone:widget.email,
                      ).then((value) async {
                        if( value['status'] == true) {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => CreateNewAccount(
                          //     ),
                          //   ),
                          // );
                          Fluttertoast.showToast(
                              msg: 'Your OTP is ${value['data']['otp']}');
                        } else {
                          Fluttertoast.showToast(
                              msg:value['message']);
                        }
                      });

                  },
                  title: 'Resent OTP',
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
                title: 'OTP Verification',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "Email Verification",
                  style: AppTextStyle().textColor29292924w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 40, right: 20),
                child: Text(
                  "Please enter the 4-digit verification code sent to ${widget.email}. The code is valid for 10 minutes.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle().textColor70707014w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                child: PinCodeTextField(
                  keyboardType: TextInputType.number,
                  controller: otpController,
                  enableActiveFill: true,
                  showCursor: false,
                  pinTheme: PinTheme(
                    fieldHeight: 52,
                    fieldWidth: 76,
                    shape: PinCodeFieldShape.box,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(8),
                    inactiveColor: ColorSelect.colorEDEDF1,
                    activeColor: ColorSelect.colorF8E6E6,
                    selectedColor: ColorSelect.colorEDEDF1,
                    selectedFillColor: Colors.grey.withOpacity(0.7),
                    activeFillColor: ColorSelect.colorEDEDF1,
                    inactiveFillColor: ColorSelect.colorEDEDF1,
                  ),
                  appContext: context,
                  length: 4,
                  onChanged: (value) {
                    setState(() {
                      // currentText = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
