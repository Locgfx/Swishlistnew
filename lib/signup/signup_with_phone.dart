import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/globals.dart';
import 'package:swishlist/signup/phone_verfication.dart';
import 'package:swishlist/signup/widgets/text_term_widget.dart';
import '../api/login_signup_apis/signup_api.dart';
import '../buttons/light_yellow.dart';

class SignUpWithPhone extends StatefulWidget {
  const SignUpWithPhone({Key? key}) : super(key: key);

  @override
  State<SignUpWithPhone> createState() => _SignUpWithPhoneState();
}

class _SignUpWithPhoneState extends State<SignUpWithPhone> {
  bool isChecked = false;
  String countryvalue = "1";
  TextEditingController phoneNoController = TextEditingController();
  final passwordController =  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return TextFieldUnFocusOnTap(
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        splashRadius: 50,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        checkColor: ColorSelect.color292929,
                        activeColor: ColorSelect.colorF7E641,
                        value: isChecked,
                        shape: CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 300.w,
                      padding: const EdgeInsets.only(right: 20, top: 16),
                      child: RichText(
                        text: TextSpan(
                          text: 'I have read and agree to SwishList',
                          style: AppTextStyle().textColor29292914w500,
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Terms of ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'Services',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' and',
                              style: AppTextStyle().textColor29292914w500,
                            ),
                            TextSpan(
                              text: ' Privacy Policy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 52.h,
                  width: 328.w,
                  child: LightYellowButtonWithText(
                    title: 'Next',
                    backgroundColor: isChecked
                        ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                        : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                    textStyleColor:
                        isChecked ? Colors.black : ColorSelect.colorB5B07A,
                    onTap: () {
                     if(isChecked) {
                       if(_formKey.currentState!.validate()) {
                         signUpApi(
                           context: context,
                           emailPhone:phoneNoController.text,
                           password: passwordController.text,
                           // password: '',
                         ).then((value) async {
                           if( value['status'] == true) {
                             Navigator.push(context,
                               MaterialPageRoute(
                                 builder: (context) => PhoneVerification(
                                   phoneNO: phoneNoController.text,
                                   password: passwordController.text,
                                 ),
                               ),
                             );
                             Fluttertoast.showToast(
                                 msg: 'Your OTP is ${value['data']['otp']}');
                           } else {
                             Fluttertoast.showToast(
                                 msg:'Already register try with another account');
                           }
                         });
                       }
                     }
                    },
                    // title: 'Next',
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
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
                      "Enter your phone number",
                      style: AppTextStyle().textColor29292924w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      "SwishList will need to verify your phone number.",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: InkWell(
                      child: Container(
                        height: 50,
                        width: 328.w,
                        decoration: BoxDecoration(
                            color: ColorSelect.colorEDEDF1,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Image.asset('assets/images/🇺🇸.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "United States",
                                style: AppTextStyle().textColor29292914w400,
                              ),
                            ),
                            SizedBox(
                              width: 180,
                            ),
                            Image.asset("assets/images/Vector458.png")
                          ],
                        ),
                      ),
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                          exclude: <String>['KN', 'MF'],
                          favorite: <String>['SE'],
                          //Optional. Shows phone code before the country name.
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            print('Select country: ${country.displayName}');
                          },
                          // Optional. Sets the theme for the country list picker.
                        );
                      },
                    ),
                  ),*/
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: ColorSelect.colorEDEDF1,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              showCountryPicker(
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  setState(() {
                                    countryvalue = country.phoneCode;
                                  });
                                },
                                context: context,
                              );
                            },
                            child: SizedBox(
                              height: 40.h,
                              width: 60,
                              child: Center(child: Text('+$countryvalue')),
                            )),
                        Container(
                          height: 20.h,
                          padding: EdgeInsets.all(5),
                          width: 3.w,
                          color: ColorSelect.colorBEBECC,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            width: 150.w,
                            child: TextFormField(
                              controller:phoneNoController ,
                              onChanged: (val) {
                              setState(() {
                                if (phoneNoController.text.trim().length ==
                                    10) {
                                  FocusScope.of(context).unfocus();
                                }
                              });
                              },
                                keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 24),
                                border: InputBorder.none,
                                hintText: "Phone Number",
                              ),
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      width: 328.w,
                      decoration: BoxDecoration(
                          color: ColorSelect.colorEDEDF1,
                          borderRadius: BorderRadius.all(Radius.circular(8),
                          ),
                        ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 24),
                              border: InputBorder.none,
                              hintText: "Password"),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
