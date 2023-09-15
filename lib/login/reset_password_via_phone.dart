import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/signup/widgets/text_term_widget.dart';
import '../api/login_signup_apis/reset_password_api.dart';
import '../constants/globals/shared_prefs.dart';
import 'login.dart';

class ResetPasswordViaPhone extends StatefulWidget {
  const ResetPasswordViaPhone({Key? key}) : super(key: key);

  @override
  State<ResetPasswordViaPhone> createState() => _ResetPasswordViaPhoneState();
}

class _ResetPasswordViaPhoneState extends State<ResetPasswordViaPhone> {
  final bool _passwordVisible = false;
  final bool _passwordVisible1 = false;

  bool tap = false;
  bool tickTwo = false;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final passController = TextEditingController();
  final conPassController = TextEditingController();
  final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();



  int currentStep = 0;
  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
          title: Text(
            "Enter your phone number",
            style: AppTextStyle().textColor29292918w500u,
          ),
          content: Container(
            width: 270.w,
            decoration: BoxDecoration(
                color: ColorSelect.colorEDEDF1,
                borderRadius:
                BorderRadius.all(Radius.circular(8))),
                 child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextFormField(
                                onChanged: (v) {
                                  setState(() {
                                    if (phoneController.text.trim().length ==
                                        10) {
                                      FocusScope.of(context).unfocus();
                                    }
                                  });
                                },
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 24),
                                    border: InputBorder.none,
                                    hintText: "phone no"),
                                // keyboardType: TextInputType.phone,
                              ),
                            ),
                          ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text(
          "Verify phone number",
          style: AppTextStyle().textColor29292918w500u,
        ),
        content: Column(
          children:  [
          Text(
            "Click on the verification link sent to ${SharedPrefs().getPhone()}.Link will be valid for 30 Minutes.",
              style: AppTextStyle().textColor70707014w400,

               // overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    controller: otpController,
                    enableActiveFill: true,
                    showCursor: false,
                    pinTheme: PinTheme(
                      fieldHeight: 42,
                      fieldWidth: 56,
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
            )
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: Text(
          "Enter new password",
          style: AppTextStyle().textColor29292918w500u,
        ),
        content: Form(
          key: _formKey,
          child: Column(
            children:  [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Type your new password",
                          style: AppTextStyle().textColor70707014w400,
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 280.w,
                          decoration: BoxDecoration(
                              color: ColorSelect.colorEDEDF1,
                              borderRadius:
                              BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: TextFormField(
                              onChanged: (v) {
                                setState(() {

                                });
                              },
                              validator: (val){
                                if(val!.isEmpty) {
                                  return 'Empty';
                                }
                                return null;
                              },
                              controller: passController,
                              decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 24),
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
                        SizedBox(height: 20),
                        Container(
                          width: 280.w,
                          decoration: BoxDecoration(
                              color: ColorSelect.colorEDEDF1,
                              borderRadius:
                              BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: TextFormField(
                              onChanged: (v) {
                                setState(() {

                                });
                              },
                              validator: (val){
                                if(val!.isEmpty) {
                                  return 'Empty';
                                }
                                if(val != passController.text) {
                                  return 'Not Match';
                                }
                                return null;
                              },
                              controller: conPassController,
                              decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 24),
                                border: InputBorder.none,
                                hintText: "Re Enter new password",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible1
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
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
           AppBarWidget(
                onPop: () {
                  Navigator.pop(context);
                },
                title: 'Reset Password',
              ),
            Theme(
            data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context)
                    .colorScheme
                    .copyWith(onSurface: ColorSelect.colorF7E641,
                    primary: ColorSelect.colorF7E641)),
              child: Stepper(
                controlsBuilder: (BuildContext context, ControlsDetails details) {
                  final _isLastStep = currentStep == getSteps().length - 1;
                  return Row(
                    children: [
                      currentStep == 0 ?
                      Container(
                        height: 50.h,
                        width: 96.w,
                        margin: const EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          child: Text(
                            "Next",style: TextStyle(
                            color:
                            (phoneController.text.isNotEmpty)
                                ? Colors.black
                                : ColorSelect.colorB5B07A,
                          ),),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: (phoneController.text.isNotEmpty)
                                ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                                : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          // onPressed: details.onStepContinue,
                          onPressed: () {
                            if(phoneController.text.isNotEmpty) {
                              // details.onStepContinue!();
                              resetPassGenerateOtpApi(
                                  emailPhone: phoneController.text)
                                  .then((value)async {
                                if( value['status'] == true) {
                                  SharedPrefs().setPhone(phoneController.text);
                                  details.onStepContinue!();
                                  Fluttertoast.showToast(
                                      msg: 'Your OTP is ${value['data']['otp']}');
                                } else {
                                  Fluttertoast.showToast(
                                      msg:'please enter a valid phone no');
                                }
                              });
                            }
                          },

                        ),

                      )
                          :SizedBox(),
                      currentStep == 1 ?
                      Container(
                        height: 50.h,
                        width: 130.w,
                        margin: const EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          child: Text(
                            "verify otp",style: TextStyle(
                            color:
                            (phoneController.text.isNotEmpty)
                                ? Colors.black
                                : ColorSelect.colorB5B07A,
                          ),),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: (phoneController.text.isNotEmpty)
                                ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                                : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (otpController.text.length == 4) {
                              details.onStepContinue!();
                            }
                          },
                          // onPressed: details.onStepContinue,
                        ),

                      ):SizedBox(),
                      currentStep == 2 ?
                      Container(
                        height: 50.h,
                        width: 96.w,
                        margin: const EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          child: Text(
                            "Login",style: TextStyle(
                            color:
                            (/*passController.text.isNotEmpty && */conPassController.text.isNotEmpty)
                                ? Colors.black
                                : ColorSelect.colorB5B07A,
                          ),),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor:(/*passController.text.isNotEmpty &&*/ conPassController.text.isNotEmpty)
                                ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                                : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )
                            ),
                          ),
                          onPressed: () {
                            if(_formKey.currentState!.validate()) {
                              resetPassValidateOtpApi(
                                  emailPhone: phoneController.text,
                                  otp: otpController.text,
                                  password:conPassController.text ).then((value) {
                                if( value['status'] == true) {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                      Login()));
                                  // details.onStepContinue!();
                                  Fluttertoast.showToast(
                                      msg:value['message']);

                                } else {
                                  Fluttertoast.showToast(
                                      msg:value['message']);
                                }
                              });
                            }
                          },
                          // onPressed: details.onStepContinue,
                        ),

                      ) :
                      SizedBox(width: 12,),
                      currentStep  ==  1 ?
                      // if (currentStep != 0)
                      Expanded(
                        child: Container(
                          height: 50.h,
                          margin: const EdgeInsets.only(top: 15),
                          child: ElevatedButton(
                            child: Text(
                              'Resend 30s',style: TextStyle(
                              color:
                              (phoneController.text.isNotEmpty)
                                  ? Colors.black
                                  : ColorSelect.colorB5B07A,
                            ),), style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: BorderSide(width:1, color:ColorSelect.colorA3A3A3),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                          ),
                            onPressed: () {
                              if(phoneController.text.isNotEmpty) {
                                // details.onStepContinue!();
                                resetPassGenerateOtpApi(
                                    emailPhone: phoneController.text)
                                    .then((value)async {
                                  if( value['status'] == true) {
                                    SharedPrefs().setPhone(phoneController.text);
                                    // details.onStepContinue!();
                                    Fluttertoast.showToast(
                                        msg: 'Your OTP is ${value['data']['otp']}');
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:value['message']);
                                  }
                                });
                              }
                            },
                            // onPressed: details.onStepContinue,
                          ),
                        ),):
                      SizedBox(),

                    ],
                  );
                },
                type: StepperType.vertical,
                currentStep: currentStep,
                onStepCancel: () => currentStep == 0
                    ? null
                    : setState(() {
                  currentStep -= 1;
                }),
                onStepContinue: () {
                  bool isLastStep = (currentStep == getSteps().length - 1);
                  if (isLastStep) {
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                onStepTapped: (step) {
                  if(step>currentStep){
                    setState((){
                      currentStep=step;
                    });
                  }
                },
                steps: getSteps(),
              ),
            ),
          ],
        ),
      ),
    );
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       AppBarWidget(
      //         onPop: () {
      //           Navigator.pop(context);
      //         },
      //         title: 'Reset Password',
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 16,
      //           vertical: 40,
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Container(
      //               color: Colors.transparent,
      //               child: Row(
      //                 children: [
      //                   tickOne ? ContainerWithTick():ContainerWithoutTick(),
      //                   Text(
      //                     "Enter your phone number",
      //                     style: AppTextStyle().textColor29292918w500u,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Container(
      //               color: Colors.transparent,
      //               child: Row(
      //                 children: [
      //                   SizedBox(width: 10),
      //                   AnimatedContainer(
      //                     duration: Duration(milliseconds: 300),
      //                     curve: Curves.fastOutSlowIn,
      //                     width: 2.w,
      //                     height: 160.h,
      //                     decoration:
      //                     BoxDecoration(
      //                       color: tickOne ? ColorSelect.colorF7E641:
      //                       ColorSelect.colorE0E0E0,
      //                     ),
      //                   ),
      //                   SizedBox(width: 20),
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       SizedBox(height: 20),
      //                       Container(
      //                         width: 270.w,
      //                         decoration: BoxDecoration(
      //                             color: ColorSelect.colorEDEDF1,
      //                             borderRadius:
      //                             BorderRadius.all(Radius.circular(8))),
      //                         child: Padding(
      //                           padding: const EdgeInsets.only(left: 20),
      //                           child: TextFormField(
      //                             onChanged: (v) {
      //                               setState(() {
      //
      //                               });
      //                             },
      //                             controller: emailController,
      //                             decoration: InputDecoration(
      //                                 contentPadding:
      //                                 EdgeInsets.symmetric(vertical: 24),
      //                                 border: InputBorder.none,
      //                                 hintText: "phone no"),
      //                             // keyboardType: TextInputType.phone,
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         height: 20,
      //                       ),
      //                       SizedBox(
      //                         height: 52.h,
      //                         width: 96.w,
      //                         child: LightYellowButtonWithText(
      //                             backgroundColor: (emailController.text.isNotEmpty)
      //                                 ? MaterialStateProperty.all(ColorSelect.colorF7E641)
      //                                 : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
      //                             textStyleColor: (emailController.text.isNotEmpty)
      //                                 ? Colors.black
      //                                 : ColorSelect.colorB5B07A,
      //                             onTap: () {
      //                               setState(() {
      //                                 tickOne = !tickOne;
      //                               });
      //                               if(emailController.text.isNotEmpty){
      //                                 resetPassGenerateOtp(
      //                                     emailPhone: emailController.toString()).
      //                                 then((value)async{
      //                                   if(value['status'] == true) {
      //                                     Fluttertoast.showToast(
      //                                         msg: 'Your OTP is ${value['data']['otp']}');
      //                                   } else {
      //                                     Fluttertoast.showToast(
      //                                         msg: value['message']);
      //                                   }
      //                                 },
      //                                 );
      //                               }
      //                             },
      //                             title: 'Next'),
      //                       ),
      //                       SizedBox(height: 20),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Row(
      //               children: [
      //                 Container(
      //                   height: 23,
      //                   width: 23,
      //                   margin: EdgeInsets.only(right: 10),
      //                   decoration: BoxDecoration(
      //                     shape: BoxShape.circle,
      //                     border: Border.all(
      //                       color: tickOne?ColorSelect.colorF7E641:ColorSelect.colorE0E0E0,
      //                       width: 2,
      //                     ),
      //                   ),
      //                 ),
      //                 Text(
      //                   "Verify phone",
      //                   style:tickOne ? AppTextStyle().textColor29292918w500u:
      //                   AppTextStyle().textColorA3A3A318w500,
      //                 ),
      //               ],
      //             ),
      //             Container(
      //               color: Colors.transparent,
      //               child: Row(
      //                 children: [
      //                   SizedBox(width: 10),
      //                   AnimatedContainer(
      //                     duration: Duration(milliseconds: 300),
      //                     curve: Curves.fastOutSlowIn,
      //                     width: 2.w,
      //                     height: tickOne ? 150:70.h,
      //                     decoration:
      //                     BoxDecoration(color: ColorSelect.colorE0E0E0),
      //                   ),
      //                   SizedBox(width: 20),
      //                   AnimatedContainer(
      //                     duration: Duration(milliseconds: 300),
      //                     curve: Curves.fastOutSlowIn,
      //                     height: tickOne ?150:0,
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         SizedBox(height: 20),
      //                         Text(
      //                           "Click on the verification link sent to phone no.\n Link will be valid for 30 Minutes.",
      //                           style: AppTextStyle().textColor70707014w400,
      //                           overflow: TextOverflow.ellipsis,
      //                         ),
      //                         SizedBox(
      //                           height: 20,
      //                         ),
      //                         Row(
      //                           children: [
      //                             SizedBox(
      //                               height: 52.h,
      //                               child: YellowButtonWithText(
      //                                   backgroundColor:
      //                                   MaterialStateProperty.all(
      //                                       ColorSelect.colorF7E641),
      //                                   textStyleColor:Colors.black,
      //                                   onTap: () {},
      //                                   title: 'Open messages'),
      //                             ),
      //                             SizedBox(
      //                               width: 10,
      //                             ),
      //                             SizedBox(
      //                               height: 52.h,
      //                               child: ResendButtonWithText(
      //                                 backgroundColor:
      //                                 MaterialStateProperty.all(Colors.white),
      //                                 textStyleColor: ColorSelect.color292929,
      //                                 onTap: () {
      //                                   /*Navigator.pushReplacement(
      //                                 context,
      //                                 MaterialPageRoute(
      //                                     builder: (context) => SignUpWithPhone()));*/
      //                                 },
      //                                 title: 'Resend',
      //                                 title1: '30s',
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                         // SizedBox(
      //                         //   height: 20,
      //                         // ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Row(
      //               children: [
      //                 Container(
      //                   height: 23,
      //                   width: 23,
      //                   margin: EdgeInsets.only(right: 10),
      //                   decoration: BoxDecoration(
      //                     shape: BoxShape.circle,
      //                     border: Border.all(
      //                       color: ColorSelect.colorE0E0E0,
      //                       width: 2,
      //                     ),
      //                   ),
      //                 ),
      //                 Text(
      //                   "Enter new password",
      //                   style: AppTextStyle().textColorA3A3A318w500,
      //                 ),
      //               ],
      //             ),
      //            Row(
      //               children: [
      //                 SizedBox(width: 30),
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   child ren: [
      //                     SizedBox(height: 20),
      //                     Text(
      //                       "Type your new password",
      //                       style: AppTextStyle().textColor70707014w400,
      //                     ),
      //                     SizedBox(height: 20),
      //                     Container(
      //                       width: 280.w,
      //                       decoration: BoxDecoration(
      //                           color: ColorSelect.colorEDEDF1,
      //                           borderRadius:
      //                           BorderRadius.all(Radius.circular(8))),
      //                       child: Padding(
      //                         padding: const EdgeInsets.only(left: 20),
      //                         child: TextFormField(
      //                           decoration: InputDecoration(
      //                             contentPadding:
      //                             EdgeInsets.symmetric(vertical: 24),
      //                             border: InputBorder.none,
      //                             hintText: "Enter new password",
      //                             suffixIcon: IconButton(
      //                               icon: Icon(
      //                                 // Based on passwordVisible state choose the icon
      //                                 _passwordVisible
      //                                     ? Icons.visibility
      //                                     : Icons.visibility_off,
      //                                 color: Colors.grey,
      //                               ),
      //                               onPressed: () {},
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(height: 20),
      //                     Container(
      //                       width: 280.w,
      //                       decoration: BoxDecoration(
      //                           color: ColorSelect.colorEDEDF1,
      //                           borderRadius:
      //                           BorderRadius.all(Radius.circular(8))),
      //                       child: Padding(
      //                         padding: const EdgeInsets.only(left: 20),
      //                         child: TextFormField(
      //                           decoration: InputDecoration(
      //                             contentPadding:
      //                             EdgeInsets.symmetric(vertical: 24),
      //                             border: InputBorder.none,
      //                             hintText: "Re Enter new password",
      //                             suffixIcon: IconButton(
      //                               icon: Icon(
      //                                 // Based on passwordVisible state choose the icon
      //                                 _passwordVisible1
      //                                     ? Icons.visibility
      //                                     : Icons.visibility_off,
      //                                 color: Colors.grey,
      //                               ),
      //                               onPressed: () {},
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: 20.h,
      //                     ),
      //                     SizedBox(
      //                       height: 52.h,
      //                       child: YellowButtonWithText(
      //                         backgroundColor: MaterialStateProperty.all(
      //                             ColorSelect.colorF7E641),
      //                         textStyleColor: ColorSelect.color292929,
      //                         onTap: () {
      //                           /*Navigator.push(
      //                             context,
      //                             MaterialPageRoute(
      //                               builder: (_) => Dashboard(),
      //                             ),
      //                           );*/
      //                           Navigator.pop(context);
      //                         },
      //                         title: 'Go to login',
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
  }
}
