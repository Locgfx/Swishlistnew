import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    print('check token ${_fcmToken} check token');
    //NotificationTokenApi().get();
    // authUserApi(fcmToken: _fcmToken).then((value) async {});
  }

  setPage() {
    SharedPrefs().init();
    bool loginBool;
    bool firstRun;

    Future.delayed(Duration(seconds: 3), () {
      firstRun = SharedPrefs().getFirstRun() ?? false;
      loginBool = SharedPrefs().getLogin() ?? false;

      if (firstRun) {
        if (loginBool) {
          print('check token${SharedPrefs().getLoginToken()}');
          LoginResponse response;

          // Assuming authTokenLoginApi returns a Future<LoginResponse>
          authTokenLoginApi(
            token: '${SharedPrefs().getLoginToken()}',
            fcmToken: _fcmToken,
          ).then((value) async {
            // Check the type of 'value' returned by authTokenLoginApi
            if (value is LoginResponse) {
              response = value;
              if (response.status == true) {
                SharedPrefs().setLoginToken(response.token);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Dashboard(response: response),
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
          });
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => Login(),
            ),
          );
        }
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

  // setPage() {
  //   SharedPrefs().init();
  //   bool loginBool;
  //   bool firstRun;
  //   Future.delayed(Duration(seconds: 3), () {
  //     firstRun = SharedPrefs().getFirstRun() ?? false;
  //     loginBool = SharedPrefs().getLogin() ?? false;
  //     if (firstRun) {
  //       if (loginBool) {
  //         print('check token${SharedPrefs().getLoginToken()}');
  //         LoginResponse response;
  //         authTokenLoginApi(
  //                 token: '${SharedPrefs().getLoginToken()}',
  //                 fcmToken: _fcmToken)
  //             .then((value) async {
  //           response = value;
  //           if (response.status == true) {
  //             SharedPrefs().setLoginToken(response.token);
  //             Navigator.of(context).pushReplacement(
  //               MaterialPageRoute(
  //                 builder: (context) => Dashboard(response: response),
  //               ),
  //             );
  //           }
  //         });
  //       } else {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (_) => Login(),
  //           ),
  //         );
  //       }
  //     } else {
  //       SharedPrefs.setFirstRunDone();
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => IntroPage(),
  //         ),
  //       );
  //     }
  //   });
  // }

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
