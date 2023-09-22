import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/social_signin/google_signin.dart';
import '../../api/social_signin/google_validate_login.dart';
import '../../constants/color.dart';
import '../../constants/globals/shared_prefs.dart';
import '../../dashboard/dashboard.dart';
import '../../models/login_models.dart';

class GoogleSigninButton extends StatelessWidget {
  GoogleSigninButton({Key? key}) : super(key: key);

  LoginResponse? response;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final auth = await GoogleSignInClass().googleLogin();
        log(auth.idToken.toString());
        final resp = googleValidateToken(token: auth.idToken!);
        resp.then((value) {
          response = value;
          if (response?.status != null && response!.status == true) {
            SharedPrefs().setGoogleTrue();
            SharedPrefs().setGoogleToken(auth.idToken!);
            SharedPrefs().setName(response!.data.name.toString());
            SharedPrefs().setUsername(response!.data.username.toString());
            SharedPrefs().setUserPhoto(response!.data.photo.toString());
            SharedPrefs().setEmail(response!.data.email.toString());
            SharedPrefs().setPassword(response!.token);
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
      },
      child: Container(
          height: 48,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
          child: SvgPicture.asset("assets/icons/flat-color-icons_google.svg",
              height: 20, width: 20, fit: BoxFit.scaleDown)),
    );
  }
}
