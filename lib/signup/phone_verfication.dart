import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/globals.dart';
import 'package:swishlist/login/login.dart';
import 'package:swishlist/models/login_models.dart';
import 'package:swishlist/models/signup_models.dart';
import 'package:swishlist/signup/widgets/text_term_widget.dart';
import '../api/login_signup_apis/signup_api.dart';
import '../buttons/white_button.dart';
import '../constants/globals/shared_prefs.dart';
import '../create_new_account/create_new_account.dart';
import '../create_new_account/create_new_account_by_phone.dart';
import '../dashboard/dashboard.dart';
import 'email_verfication.dart';

class PhoneVerification extends StatefulWidget {
  final String phoneNO;
  final String password;
  const PhoneVerification({Key? key, required this.phoneNO,
    required this.password}) : super(key: key);

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final otpController = TextEditingController();
  LoginResponse? response;
  bool loading = false;
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
                      setState(() {
                        loading = true;
                      });
                      verifyOtp(
                        context: context,
                        otp: otpController.text,
                        email: widget.phoneNO,
                        password: widget.password,
                      ).then((value)async {
                        setState(() {
                          loading = false;
                        });
                        response = value;
                        if(response?.status != null && response!.status == true) {
                          print(response);
                          SharedPrefs().setLoginToken(response!.token);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CreateNewAccountByPhone(phoneNo:widget.phoneNO ,),
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
                      emailPhone:widget.phoneNO,
                    ).then((value) async {
                      if( value['status'] == true) {
                        Fluttertoast.showToast(
                            msg: 'Your OTP is ${value['data']['otp']}');
                      } else {
                        Fluttertoast.showToast(
                            msg:value['message']);
                      }
                    });
                    /*Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneVerification()));*/
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
                  "Phone Verification",
                  style: AppTextStyle().textColor29292924w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 40, right: 20),
                child: Text(
                  "Please enter the 4-digit verification code sent to ${widget.phoneNO}. The code is valid for 10 minutes.",
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
