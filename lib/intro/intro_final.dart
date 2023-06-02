import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color.dart';

class IntroFinal extends StatefulWidget {
  final Function onBackTap;
  const IntroFinal({Key? key, required this.onBackTap}) : super(key: key);

  @override
  State<IntroFinal> createState() => _IntroFinalState();
}

class _IntroFinalState extends State<IntroFinal> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationController1;
  late AnimationController animationController2;
  late AnimationController animationController3;
  late Animation<double> _animation;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  @override
  void dispose() {
    animationController.dispose();
    animationController1.dispose();
    animationController2.dispose();
    animationController3.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    animationController1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..forward(from: 0.0).then((value) => animationController2
        .forward()
        .then((value) => animationController3.forward()));
    animationController2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animationController3 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation1 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController1,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animation2 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController2,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animation3 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController3,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animation = Tween<double>(
      begin: 1,
      end: 3,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    //animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () {
            widget.onBackTap();
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              "assets/icons/arrowback.svg",
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 123.h,
          ),
          FadeTransition(
            opacity: _animation1,
            child: Text(
              "Let's",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorSelect.colorF7E641,
                ),
              ),
            ),
          ),
          FadeTransition(
            opacity: _animation2,
            child: Text(
              "Get",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorSelect.colorF7E641,
                ),
              ),
            ),
          ),
          FadeTransition(
            opacity: _animation3,
            child: ScaleTransition(
              scale: _animation,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    "Swishing!",
                    style: AppTextStyle().textColorF7E64120w700,
                  ),
                ),
              ),
            ),
          ),
          /*_scale(),*/
          Spacer(),
        ],
      ),
    );
  }
}
