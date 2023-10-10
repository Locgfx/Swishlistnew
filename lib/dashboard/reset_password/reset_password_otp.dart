import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../buttons/light_yellow.dart';
import '../../constants/color.dart';
import '../../constants/globals/globals.dart';
import '../../signup/widgets/text_term_widget.dart';

class ResetPasswordOtp extends StatefulWidget {
  const ResetPasswordOtp({Key? key}) : super(key: key);

  @override
  State<ResetPasswordOtp> createState() => _ResetPasswordOtpState();
}

class _ResetPasswordOtpState extends State<ResetPasswordOtp> {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
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
                  child: LightYellowButtonWithText(
                      backgroundColor: (otpController.text.isNotEmpty)
                          ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                          : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                      textStyleColor: (otpController.text.isNotEmpty)
                          ? Colors.black
                          : ColorSelect.colorB5B07A,
                      onTap: () {
                        // resetPassValidateOtpApi(
                        //         emailPhone: emailController.text,
                        //         otp: otpController.text,
                        //         password: conPassController.text)
                        //     .then((value) {
                        //   if (value['status'] == true) {
                        //     Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //           builder: (context) => ResetNewPassword()),
                        //     );
                        //     // details.onStepContinue!();
                        //     Fluttertoast.showToast(msg: value['message']);
                        //   } else {
                        //     Fluttertoast.showToast(msg: value['message']);
                        //   }
                        // });
                      },
                      title: 'Next'),
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
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
                      "30 sec",
                      style: AppTextStyle().robotocolor70707014w400,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
