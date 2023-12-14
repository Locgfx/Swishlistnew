import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/api/fcm_notiifcations/fcm_notification_apis.dart';
import 'package:swishlist/api/login_signup_apis/login_api.dart';
import 'package:swishlist/api/user_apis/auth_user_api.dart';

import '../constants/globals/shared_prefs.dart';
import '../dashboard/dashboard.dart';
import '../intro/intro_page.dart';
import '../login/login.dart';
import '../models/login_models.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setPage();
    initializeFirebaseService();
    // startTime();
  }

  String _fcmToken = '';
  Future<void> initializeFirebaseService() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String firebaseAppToken = await messaging.getToken(
          vapidKey:
              "BNBIPSYT_iCs6OeciJS8R3l4vouFWut_AldR16nowfLEgWdHh11q5_NDsRVRZtY4fYLqcvk4vu8B4Lzc_7GSnGk",

        ) ??
        '';
    if (!mounted) {
      _fcmToken = firebaseAppToken;
    } else {
      setState(() {
        _fcmToken = firebaseAppToken;
      });
    }

    SharedPrefs().setFcmToken(_fcmToken);

    // var prefs = await SharedPreferences.getInstance();
    // prefs.setString(Keys().fcmToken, _fcmToken);
    print('Firebase token: $firebaseAppToken');
    print(_fcmToken);
    // NotificationTokenApi().get();
    // authUserApi(fcmToken: _fcmToken).then((value) async {});
    fcmNotificationTokenApi(fcmToken: _fcmToken).then((value) {

    });
  }

  setPage() {
    SharedPrefs().init();
    bool loginBool;
    bool firstRun;
    bool signLogin;
    bool googleLoginBool;
    bool appleLoginBool;
    Future.delayed(Duration(seconds: 3), () {
      firstRun = SharedPrefs().getFirstRun() ?? false;
      loginBool = SharedPrefs().getLogin() ?? false;
      signLogin = SharedPrefs().getSignLogin() ?? false;
      googleLoginBool = SharedPrefs().getGoogleLogin() ?? false;
      appleLoginBool = SharedPrefs().getAppleLogin() ?? false;
      if (firstRun) {
        // if (loginBool) {
        //   print('login');
        //   LoginResponse response;
        //   login(
        //     context: context,
        //     email: SharedPrefs().getEmail()!,
        //     password: SharedPrefs().getPassword()!,
        //   ).then((value) async {
        //     response = value;
        //     if (response.status == true) {
        //       SharedPrefs().setLoginTrue();
        //       SharedPrefs().setLoginToken(response.token);
        //       print(response.token);
        //       SharedPrefs().setId(response.data.id.toString());
        //       print(response.data.id.toString());
        //       Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(
        //           builder: (context) => Dashboard(response: response),
        //         ),
        //       );
        //     }
        //   });
        // }
        if (loginBool) {
          print('check token${SharedPrefs().getLoginToken()}');
          LoginResponse? response;
          login(
            context: context,
            email: SharedPrefs().getEmail().toString(),
            password: SharedPrefs().getPassword().toString(),
          ).then((value) {
            if (value is LoginResponse) {
              response = value;
              if (response?.error != null &&
                  response!.error == false) {
                SharedPrefs().setLoginTrue();
                SharedPrefs()
                    .setEmail(response!.data!.email.toString());
                // SharedPrefs()
                //     .setPassword(passwordController.text);
                SharedPrefs()
                    .setLoginToken(response!.token.toString());
                SharedPrefs()
                    .setId(response!.data!.id.toString());
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Dashboard(response: response!),
                  ),
                );
              }
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Login(),
                ),
              );
              // Handle the case where authTokenLoginApi returns an unexpected type
            }
            // response = value;
            // if (response?.error != null &&
            //     response!.error == false) {
            //
            //   SharedPrefs().setLoginTrue();
            //   SharedPrefs()
            //       .setEmail(response!.data!.email.toString());
            //   // SharedPrefs()
            //   //     .setPassword(passwordController.text);
            //   SharedPrefs()
            //       .setLoginToken(response!.token.toString());
            //   SharedPrefs()
            //       .setId(response!.data!.id.toString());
            //   // SharedPrefs().setName(
            //   //     response!.data.name.toString());
            //   // SharedPrefs().setUsername(
            //   //     response!.data.username.toString());
            //   // SharedPrefs().setUserPhoto(
            //   //     response!.data.photo.toString());
            //   Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(
            //       builder: (context) =>
            //           Dashboard(response: response!),
            //     ),
            //   );
            //   // Navigator.pushReplacement(
            //   //   context,
            //   //   MaterialPageRoute(
            //   //     builder: (_) => ShowCaseWidget(
            //   //         builder: Builder(
            //   //       builder: (context) =>
            //   //           Dashboard(response: response!),
            //   //     )),
            //   //   ),
            //   // );
            // }
          });
      /*    authTokenLoginApi(
                  token: '${SharedPrefs().getLoginToken()}',
                  fcmToken: _fcmToken)
              .then((value) async {
            response = value;
            if (response.error == false) {
              SharedPrefs().setLoginToken(response.token.toString());
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Dashboard(response: response),
                ),
              );
            }
          });*/
        }
        // else if (appleLoginBool) {
        //   LoginResponse response;
        //   authUserApi().then((value) async {
        //     response = value;
        //     if (response.status == true) {
        //       // SharedPrefs().setLoginToken(response.token);
        //
        //       Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(
        //           builder: (context) => Dashboard(response: response),
        //         ),
        //       );
        //     }
        //   });
        // }
        else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => Login(),
            ),
          );
        }
        // if (googleLoginBool) {
        //   LoginResponse response;
        //   authUserApi().then((value) async {
        //     response = value;
        //     if (response.status == true) {
        //       // SharedPrefs().setLoginToken(response.token);
        //
        //       Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(
        //           builder: (context) => Dashboard(response: response),
        //         ),
        //       );
        //     } else {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (_) => Login(),
        //         ),
        //       );
        //     }
        //   });
        // }
      } else {
        SharedPrefs.setFirstRunDone();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => IntroPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            width: 1.sw,
            child: Image.asset(
              "assets/images/Vector3028.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Spacer(),
          Image.asset(
            'assets/images/splash.png',
            height: 250,
          ),
          Spacer(),
          SizedBox(
            width: 1.sw,
            child: Image.asset(
              "assets/images/Vector3029.png",
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomLeft,
            ),
          ),
        ],
      ),
    );
  }
}
