import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../api/social_signin/apple_signin_token_validate.dart';
import '../../constants/color.dart';
import '../../constants/globals/shared_prefs.dart';
import '../../dashboard/dashboard.dart';
import '../../models/login_models.dart';

class AppleLoginButton extends StatelessWidget {
  AppleLoginButton({Key? key}) : super(key: key);

  LoginResponse? response;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // var _prefs = await SharedPreferences.getInstance();
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        print(credential.authorizationCode);

        final resp =
            getAppleValidateToken(authorizedCode: credential.authorizationCode);
        resp.then((value) {
          response = value;
          if (response?.status != null && response!.status == true) {
            SharedPrefs().setAppleToken(credential.authorizationCode);
            SharedPrefs().setAppleTrue();
            SharedPrefs().setName(response!.data.name.toString());
            SharedPrefs().setUsername(response!.data.username.toString());
            SharedPrefs().setUserPhoto(response!.data.photo.toString());
            SharedPrefs().setEmail(response!.data.email.toString());
            SharedPrefs().setPassword(credential.authorizationCode);
            SharedPrefs().setLoginToken(response!.token);
            SharedPrefs().setId(response!.data.id.toString());
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Dashboard(response: response!),
              ),
            );
          } else {
            Fluttertoast.showToast(msg: "Login Failed Please Try Again");
          }
        });
        // print(credential);

        // getAppleValidateToken(
        //     authorizedCode: '', token: '', name: '', email: '');
      },
      child: Container(
          height: 48,
          width: 1.sw,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/icons8-apple-logo-50 1.png",
                  height: 20, width: 20, fit: BoxFit.scaleDown),
              SizedBox(width: 6),
              Text(
                'Sign in with Apple',
                style: AppTextStyle().textColor00000014w400,
              ),
            ],
          )),
    );
  }
}
