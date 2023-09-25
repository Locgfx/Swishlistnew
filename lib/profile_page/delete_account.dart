import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../api/user_apis/delete_account_api.dart';
import '../buttons/light_yellow.dart';
import '../constants/color.dart';
import '../constants/globals/globals.dart';
import '../login/login.dart';
import '../signup/widgets/text_term_widget.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final otpController = TextEditingController();
  bool loading = false;

  bool show = false;

  Timer? _timer;
  int _start = 60;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
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
        bottomNavigationBar: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 52.h,
                width: 328.w,
                child: show
                    ? LoadingLightYellowButton()
                    : LightYellowButtonWithText(
                        backgroundColor: otpController.text.length == 4
                            ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                            : MaterialStateProperty.all(
                                ColorSelect.colorFCF5B6),
                        textStyleColor: otpController.text.length == 4
                            ? Colors.black
                            : ColorSelect.colorB5B07A,
                        onTap: () {
                          setState(() {
                            show = !show;
                          });
                          Timer timer = Timer(Duration(seconds: 2), () {
                            setState(() {
                              show = false;
                            });
                          });
                          if (otpController.text.length == 4) {
                            deleteAccountOtpApi(otp: otpController.text)
                                .then((value) async {
                              Fluttertoast.showToast(msg: value['message']);
                              if (value['status'] == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Login(),
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(msg: value['message']);
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
              GestureDetector(
                onTap: _start == 0
                    ? () {
                        setState(() {
                          _start = 60;
                        });
                        _startTimer();
                        deleteAccountApi().then((value) async {
                          if (value['status'] ==
                                  true /*&&
                              response!.status == true*/
                              ) {
                            Fluttertoast.showToast(
                                msg: 'Your OTP is ${value['data']['otp']}');

                            // print(pickedImage.toString());
                            // print(updateNameController.text);
                          } else {
                            Fluttertoast.showToast(msg: value['message']);
                          }
                        });
                      }
                    : () {},
                child: Container(
                  height: 52.h,
                  width: 328.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: ColorSelect.colorA3A3A3,
                      )),
                  child: Center(
                    child: Text(
                      'Resend ${_start}s',
                      style: AppTextStyle().textColor29292914w500,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 52.h,
              //   width: 328.w,
              //   child: WhiteButtonWithText(
              //     backgroundColor: MaterialStateProperty.all(Colors.white),
              //     textStyleColor: ColorSelect.color292929,
              //     onTap: () {
              //       deleteAccountApi().then((value) async {
              //         if (value['status'] ==
              //                 true /*&&
              //                 response!.status == true*/
              //             ) {
              //           Fluttertoast.showToast(
              //               msg: 'Your OTP is ${value['data']['otp']}');
              //
              //           // print(pickedImage.toString());
              //           // print(updateNameController.text);
              //         } else {
              //           Fluttertoast.showToast(msg: value['message']);
              //         }
              //       });
              //     },
              //     title: 'Resent OTP',
              //   ),
              // ),
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
                  "Please enter the 4-digit verification code ",
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
