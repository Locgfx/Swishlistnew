import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/dashboard/reset_password/reset_new_password.dart';

import '../../api/reset_pass_api.dart';
import '../../buttons/light_yellow.dart';
import '../../constants/color.dart';
import '../../constants/globals/globals.dart';
import '../../signup/widgets/text_term_widget.dart';

class ResetPasswordOtp extends StatefulWidget {
  final String email;
  const ResetPasswordOtp({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPasswordOtp> createState() => _ResetPasswordOtpState();
}

class _ResetPasswordOtpState extends State<ResetPasswordOtp> {
  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  bool show = false;

  final emailController = TextEditingController();
  final otpController = TextEditingController();

  Timer? _timer;
  //int _start = 300;

  int _remainingMinutes = 5;
  int _remainingSeconds = 0;

  // _startTimer() {
  //
  //   const oneMinute = const Duration(minutes: 1);
  //   _timer = Timer.periodic(
  //     oneMinute,
  //     (Timer timer) {
  //       setState(() {
  //         if (_remainingMinutes > 0) {
  //           _remainingMinutes--;
  //         } else {
  //           timer.cancel();
  //           // Handle timer completion, e.g., re-enable the "Resend OTP" button
  //         }
  //       });
  //     },
  //   );
  // }


  _startTimer(){
    const oneSecond = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else if (_remainingMinutes > 0) {
          _remainingMinutes--;
          _remainingSeconds = 59;
        } else {
          timer.cancel();

        }
      });
    });
  }


  String formatTime() {

    String minutes = _remainingMinutes.toString().padLeft(2, '0');
    String seconds = _remainingSeconds.toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                    "assets/images/cuate.png",
                    height: 194,
                    width: 264,
                  ),
                ),
                SizedBox(
                  height: 88,
                ),
                Text(
                  'Enter your OTP',
                  style: AppTextStyle().textColor29292916w500,
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
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
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 52,
                  child: otpController.text.isEmpty
                      ? LightYellowButtonWithText(
                          backgroundColor: MaterialStateProperty.all(
                              ColorSelect.colorFCF5B6),
                          textStyleColor: ColorSelect.colorB5B07A,
                          onTap: () {},
                          title: 'Please Enter OTP')
                      : show
                          ? LoadingLightYellowButton()
                          : LightYellowButtonWithText(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorSelect.colorF7E641),
                              textStyleColor: Colors.black,
                              onTap: () {
                                setState(() {
                                  show = !show;
                                });
                                Timer timer = Timer(Duration(seconds: 2), () {
                                  setState(() {
                                    show = false;
                                  });
                                });
                                resetPassOtpApi(
                                  email:
                                      SharedPrefs().getChangeEmail().toString(),
                                  otp: otpController.text,
                                ).then((value) {
                                  if (value['status'] == true) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResetNewPassword(
                                                email: widget.email,
                                              )),
                                    );
                                    // details.onStepContinue!();
                                    Fluttertoast.showToast(
                                        msg: value['message']);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: value['message']);
                                  }
                                });
                              },
                              title: 'Next'),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){

                    setState(() {
                      _remainingMinutes = 5;
                      _remainingSeconds = 0;
                    });
                    _startTimer();
                    // _remainingMinutes == 0
                  //     ? () {
                  //         setState(() {
                  //           _remainingMinutes = 5;
                  //         });

                          resetPassApi(
                                  email:
                                      SharedPrefs().getChangeEmail().toString())
                              .then((value) async {
                            if (value['status'] == true) {
                              // Navigator.of(context).pushReplacement(
                              //   MaterialPageRoute(
                              //       builder: (context) => ResetPasswordOtp(
                              //             email: emailController.text,
                              //           )),
                              // );
                              // Fluttertoast.showToast(
                              //     msg: 'Your OTP is ${value['data']['otp']}');
                            } else {
                              Fluttertoast.showToast(msg: value['message']);
                            }
                          });
                        },
                     // : () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    // color: Colors.redAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Resend",
                          style: AppTextStyle().roboto29292914w500,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          formatTime(),
                          style: AppTextStyle().robotocolor70707014w400,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
