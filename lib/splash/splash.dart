import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:swishlist/api/login_signup_apis/login_api.dart';
import 'package:swishlist/models/login_models.dart';
import '../constants/globals/shared_prefs.dart';
import '../dashboard/dashboard.dart';
import '../intro/intro_page.dart';
import '../login/login.dart';

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
    // startTime();
  }


  setPage() {
    SharedPrefs().init();
    bool loginBool;
    bool firstRun;
    bool signLogin;
    Future.delayed(
      Duration(seconds: 3),
        () {
          firstRun = SharedPrefs().getFirstRun() ?? false;
          loginBool = SharedPrefs().getLogin() ?? false;
          signLogin = SharedPrefs().getSignLogin() ?? false;
          if(firstRun) {
            if(loginBool) {
              LoginResponse response;
              login(
                context: context,
                email: SharedPrefs().getEmail()!,
                password: SharedPrefs().getPassword()!,
              ).then((value)async {
                response = value;
                if (response.status == true) {
                  SharedPrefs().setLoginTrue();
                  SharedPrefs().setLoginToken(response.token);
                  print(response.token);
                  SharedPrefs().setId(response.data.id.toString());
                  print(response.data.id.toString());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ShowCaseWidget(builder: Builder(builder: (context) => Dashboard(response: response),
                      )),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Login(),
                    ),
                  );
                }
              });
            } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Login(),
              )
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
